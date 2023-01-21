---
title: "Adventures in Jenkins"
date: 2023-01-20T23:17:51-05:00
tags:
  - devops
  - jenkins
image:
comments: true
draft: true
---

## The 20 Foot View

As I mentioned previously, I am hoping to get a bit of CI up and running for this (and other) projects that I've been working on. The first step was setting up Jenkins so I can more easily deploy changes on the go. Theoretically, that would allow me to make updates to this site more easily.

I'm going with [Jenkins](https://www.jenkins.io/) because it's easier to self-host and I want to eventually get all  the projects I really care about off of GitHub. Again, I detest the idea of a centralized internet. We've already seen what GitHub will do with our code without asking us. I have an absolutely awful Discord bot buried somewhere in Sweden because of them. Not to mention CoPilot, which they are now *charging* us for. The audacity, to make us pay for our own code! It's baffling. I hope to have a git server up in Oceanetes soon, though.

Speaking of Oceanetes, that is my current managed cluster in DigitalOcean. Right now I'm shuffling things around so most of my projects are hosted on Oceanetes, which is fine but (again) kinda not ideal for me. But that's where we're starting with Jenkins. The benefit of using DigitalOcean is that it's cheap. The cost is that I'm learning something that's only useful at a small scale but I'm using tools for doing things at larger scales. Thankfully, DO doesn't get too in the weeds with their offerings so I'm not as intimidated by it as compared to AWS's wall of incomprehensible bullshit. 

Fuck Amazon, dude. Wait where was I?

## Cert-Manager and Ingress

So far the biggest lesson I would have to impart on you, reader, is how easy it is to get TLS working with cert-manager on your cluster. It's so easy, in fact, I think getting cert-manager installed on your lab cluster is maybe one of the first things you should do. [SSL/TLS certs](https://www.linuxjournal.com/content/how-secure-your-website-openssl-and-ssl-certificates) are going to be massively important in the decentralized authentication of the future. In fact, authenticatation is exactly what they're for. They confirm that the domain *name* owner is the same person as the content owner. It's increasingly important that you confirm that the content you're receiving is in fact from who you're expecting it to be from, take Musk's Twitter for example.

So how do we do this?

What we will need:
- A Kubernetes cluster and kubectl
- [Helm](https://helm.sh/docs/intro/install/)
- Patience

