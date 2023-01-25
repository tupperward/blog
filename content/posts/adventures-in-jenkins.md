---
title: "Adventures in Labbing: Part 3 - Jenkins"
date: 2023-01-25T00:23:19-05:00
tags:
  - jenkins
  - ci
  - adventures in labbing
  - gitlab
image:
comments: false
---

Fuck [Jenkins](https://www.jenkins.io/) man.

I do this shit for work, not for fun. I'm already done. The problem I'm running into is specifically around credentials, which I feel should be fairly easy to manage with Kubernetes secrets but apparently not for Jenkins. Fighting with the UI and the settings, I'm just...I think I'm done? I'm going to leave it installed for now because I think it might actually be something I come back around to in a week or so. Maybe on my trip next week if I need some time to myself. Whatever, I'm not getting paid for this right now this is entirely for my own purposes. 

Overall the goal is to get CI working so I can simply PR to the `main` branch of the repo containing this blog with each update as I work on it and then the pipeline takes care of everything as it's deployed into kubernetes. I want to get this done by tomorrow evening so I can make quick posts on the road in Texas this weekend.[^1]

The other thing is I was looking at [self-hosting Gitlab](https://about.gitlab.com/install/). This could be a promising way to take care of two birds with one stone: self hosting my own code repos and container registries as well as having CI built right in? That's mighty tempting. I think it's going to be a much bigger undertaking than I currently expect them to be. Until then, I think I might just have to rely on self-hosted github action runners. This will at least get the container images built and pushed, and I can worry about refreshing my production images shortly.

n8n is working fantastically except it appears to be giving me one issue as well. It's double posting. Every time a workflow runs it does sends the result twice. I just realized why while typing this out. Hold up.

```
❯ kgp -n n8n
NAME                   READY   STATUS             RESTARTS   AGE
n8n-66bff5d4cb-676rq   1/1     Running            0          27h
n8n-7df76b6594-c9m58   1/1     Running            0          27h
```

These dumb assholes execute from both pods. What stupid bullshit. Ha. Well, spoilers, scaling down to 1 replica fixed it. I've got some docs to read or a bug report to file.

Sorry for the disappointing update. I'm thinking I might try to get a little less technical in future posts, but since I'm in the process of setting all this up it's been a very fun thing to sort of document this along the way. I dunno, since we're going to be in Texas this weekend I expect there to be one or two more posts that are entirely devoid of technical content.

[^1]: We're taking the kiddo down to Texas for his great-granny's 94th birthday. 