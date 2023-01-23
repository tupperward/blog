---
title: "Adventures in Labbing: Part 1"
date: 2023-01-20T23:43:25-05:00
tags:
  - kubernetes
  - cert-manager
  - tls
  - ssl
  - scrappernetes
  - oceanetes
  - adventures in labbing
image:
comments: true
---

## The Importance of Being Earnest

So far the biggest lesson I would have to impart on you, reader, is how easy it is to get TLS working with cert-manager on your cluster. It's so easy, in fact, I think getting cert-manager installed on your lab cluster is maybe one of the first things you should do. [SSL/TLS certs](https://www.linuxjournal.com/content/how-secure-your-website-openssl-and-ssl-certificates) are going to be massively important in the decentralized authentication of the future. In fact, authenticatation is exactly what they're for. They confirm that the domain *name* owner is the same person as the content owner. It's increasingly important that you confirm that the content you're receiving is in fact from who you're expecting it to be from, take Musk's Twitter for example. You don't want everyone to think your famous jolly cartoon character is flipping them off do you?

## Cert-Manager and Ingress

What we will need:
- A Kubernetes cluster and kubectl
- [Helm](https://helm.sh/docs/intro/install/)
- A working [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx) (*optional, you can use whatever ingress controller you want, hon.*)
- [Patience](https://www.youtube.com/watch?v=Fafowelwoc0)

Get yourself some [cert-manager.io](https://cert-manager.io) by givin' em the [ol' razzle dazzle.](https://cert-manager.io/docs/installation/helm/)

`helm repo add jetstack https://charts.jetstack.io`

Razzle dazzle 'em.

`helm repo update`

Give 'em a show that's so splendiferous.

```
helm install \
cert-manager jetstack/cert-manager \
--namespace cert-manager \
--create-namespace \
--version v1.11.0 \
--set installCRDs=true
```

Row after row will grow vociferous.


###### staging-issuer.yaml
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: staging-issuer
spec:
  acme:
    email: yer@email.biz
    preferredChain: ""
    privateKeySecretRef:
      name: staging-issuer-private-key
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    solvers:
    - http01:
        ingress:
          class: nginx
```

Give 'em the ol' flim-flam flummox, Fool and fracture 'em.

`kubectl create -f staging-issuer.yaml`

How can they hear the truth above the roar? (roar, roar, roar)

###### prod-issuer.yaml
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: prod-issuer
spec:
  acme:
    email: yer@email.biz
    preferredChain: ""
    privateKeySecretRef:
      name: prod-issuer-private-key
    server: https://acme-v02.api.letsencrypt.org/directory
    solvers:
    - http01:
        ingress:
          class: nginx
```

Throw 'em a fake and a finagle they'll never know you're just a bagel

`kubectl create -f prod-issuer.yaml`

Razzle dazzle 'em and they'll beg you for moooooooooore![^link]

## Mr. Cellophane Is Objectively Better

Ok, so now we have a staging-issuer and a prod-issuer. Both of these are ClusterIssuer resources, so any project you call out with these on your cluster will get their requested certs. These ClusterIssuers will manage our certificate requests as we set up our ingresses. We set up two different Issuers so we don't ping the production ACME url too many times and get our domain blocked. Once we know the cert is being applied we can just swap over to the prod-issuer and get the for-real one, but to start it's always best to go with staging.

Here's what my [repcal](https://repcal.tupperward.net) site's Ingress resource looks like. Note the annotation and TLS sections.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    cert-manager.io/cluster-issuer: prod-issuer
  name: repcal
  namespace: repcal
spec:
  ingressClassName: nginx
  rules:
  - host: repcal.tupperward.net
    http:
      paths:
      - backend:
          service:
            name: repcal
            port:
              number: 80
        path: /
        pathType: Prefix
  tls:
  - hosts:
    - repcal.tupperward.net
    secretName: prod-repcal-tls
```

With that annotation, cert-manager will know which issuer use to handle your certificate request. It will then create a Certificate, CertificateRequest and Challenge CRDs inside kubernetes as well as a couple of Secets to store temporary and permanent data for the certs. You can follow this process by following these resources.

```shell
❯ k apply -f ingress.yaml
ingress.networking.k8s.io/repcal configured
❯ k get cert -n repcal
NAME              READY   SECRET            AGE
prod-repcal-tls   False   prod-repcal-tls   5s
```

And the certificate request

```shell
❯ k get cr -n repcal
NAME                    APPROVED   DENIED   READY   ISSUER        REQUESTOR                                                    AGE
prod-repcal-tls-kqczc   True                False   prod-issuer   system:serviceaccount:cert-manager:cert-manager-controller   19s
```

And the challenge
```shell
❯ k get challenge -n repcal
NAME                                         STATE     DOMAIN                  AGE
prod-repcal-tls-kqczc-614032786-1555122464   pending   repcal.tupperward.net   29s
```

Usually if the challenge isn't resolved in under a minute, you should start troubleshooting. But eventually you get this!

```shell
❯ k get cr -n repcal
NAME                    APPROVED   DENIED   READY   ISSUER        REQUESTOR                                                    AGE
prod-repcal-tls-kqczc   True                True    prod-issuer   system:serviceaccount:cert-manager:cert-manager-controller   56s
❯ k get cert -n repcal
NAME              READY   SECRET            AGE
prod-repcal-tls   True    prod-repcal-tls   61s
```

And Bob's yer@email.biz your site has a cert!

[^link]: [For Your Convenience](https://youtu.be/ByeXMGqapnU)