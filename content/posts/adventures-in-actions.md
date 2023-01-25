---
title: "Adventures in Labbing: Part 4 - Github Actions"
date: 2023-01-25T12:51:46-05:00
tags:
  - github actions
  - actions runner
  - n8n
  - automation
  - adventures in labbing
image:
comments: false
---

It's working! I set up a self-hosted action runner on one of the scrappernetes nodes and made it run as a service. This allowed me to start building out steps using the `doctl` tools after I was able to install that on the node as well. 

This makes building and deploying the blog a breeze. I even included a quick Github trigger in n8n so it knows when I've pushed a new blog post and makes a Toot promoting it with a small snippet of text from the top of the post. Here's what that looks like now.

![Mastodon Post Workflow](/posts/n8n-github.png "A n8n workflow that is triggered daily at 10 am with a schedule node, and also when a Github repo's  main branch is pushed or pull requested to. From there it goes through an RSS node, to a couple of code nodes that format the text from RSS, then posting to Mastodon as described in the previous blog entry.")

I'm exited to maybe get a couple posts done while on the road. The best thing to do might be to make a bunch of branches with pre-formatted posts ready to go so I can edit them on mobile and PR them in.

I'm just happy it's up and working! I think I'll get everything ready for the trip now.