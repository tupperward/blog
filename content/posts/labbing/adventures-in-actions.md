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
comments: true
---

It's working! I set up a self-hosted action runner on one of the scrappernetes nodes and made it run as a service. This allowed me to start building out steps using the `doctl` tools after I was able to install that on the node as well. 

This was pretty easy with the Actions Runner documentation.

###### Download
```shell
# Create a folder
$ mkdir actions-runner && cd actions-runner
# Download the latest runner package
$ curl -o actions-runner-linux-x64-2.301.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.301.1/actions-runner-linux-x64-2.301.1.tar.gz
# Optional: Validate the hash
$ echo "3ee9c3b83de642f919912e0594ee2601835518827da785d034c1163f8efdf907  actions-runner-linux-x64-2.301.1.tar.gz" | shasum -a 256 -c
# Extract the installer
$ tar xzf ./actions-runner-linux-x64-2.301.1.tar.gz
```
###### Configure
```shell
# Create the runner and start the configuration experience
$ ./config.sh --url https://github.com/foo/bar --token fubar
# Create a service.
$ ./svc.sh install
# Last step, run it!
$ ./svc.sh start
```

From there it was just a matter of making sure `runs-on: self-hosted` is in my workflow, which coincidentally looks like this.

```yaml
name: Docker

# This workflow uses actions that are not certified by GitHub.
# They are provided by a third-party and are governed by
# separate terms of service, privacy policy, and support
# documentation.

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

env:
  # Use docker.io for Docker Hub if empty
  REGISTRY: registry.digitalocean.com/foo

  # github.repository as <account>/<repo>
  IMAGE_NAME: bar

jobs:
  build:

    runs-on: self-hosted
    permissions:
      contents: read
      packages: write
      # This is used to complete the identity challenge
      # with sigstore/fulcio when running outside of PRs.
      id-token: write

    steps:
      - name: Checkout Repo
        uses: actions/checkout@v3
        with:
          repository: foo/bar
          token: ${{ secrets.GH_TOKEN }}
          ref: main

      - name: DigitalOcean Docker Image Publish
        uses: ripplr-io/docr-docker-publish@v1
        with:
          image_path: foo/bar

      # Set up the Kubernetes CLI with your DigitalOcean Kubernetes cluster.
      - name: Set up kubectl
        uses: matootie/dokube@v1.4.0
        with:
          personalAccessToken: ${{ secrets.DO_TOKEN }}
          clusterName: ward-personal-sandbox

      # Run any kubectl commands you want!
      - name: Rollout Pods
        run: kubectl rollout restart deploy -n blog blog 
```

This makes building and deploying the blog a breeze. I even included a quick Github trigger in n8n so it knows when I've pushed a new blog post and makes a Toot promoting it with a small snippet of text from the top of the post. Here's what that looks like now.

![Mastodon Post Workflow](/posts/n8n-github.png "A n8n workflow that is triggered daily at 10 am with a schedule node, and also when a Github repo's  main branch is pushed or pull requested to. From there it goes through an RSS node, to a couple of code nodes that format the text from RSS, then posting to Mastodon as described in the previous blog entry.")

I'm exited to maybe get a couple posts done while on the road. The best thing to do might be to make a bunch of branches with pre-formatted posts ready to go so I can edit them on mobile and PR them in.

I'm just happy it's up and working! I think I'll get everything ready for the trip now.