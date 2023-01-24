---
title: "Adventures in Labbing: Part 2 - Adventures in n8n"
date: 2023-01-23T21:45:20-05:00
tags:
- kubernetes
- n8n
- oceanetes
- IFTTT
- pipeline
- adventures in labbing
image:
comments: false
---

A few years back a friend of mine in a Discord server created a bot that, on request, browsed some GoComics for a given comic strip or comment if possible. We mainly used it to ask for the most recent Heathcliff, Nancy and Garfield strips, but you did have to ask for them. So usually someone in Europe would ping the bot when they woke up and bing bang boom Bob's [yer@email.biz](https://tupperward.net/posts/adventures-in-labbing/) we got our comics. But for everybody in the US this was effectively automation (so long as someone in Europe remained routine-driven, a pretty safe bet). 

I took a bit of a break from that Discord, but still wanted comics delivered right to my door, so I initially tried to set up an RSS reader in IFTTT and

![/posts/ifttt.png](/posts/ifttt.png "You're using 1 of 5 Applets")
*This is no good. I have way more than 5 bad ideas.*

Holy moly this is not gonna be sustainable. A little bit of searching brought me to a self-hosted solution. At the time I just had a little VM I hosted stuff on and I would run docker-compose stacks as needed and there was a free, self-hosted project called [n8n](https://n8n.io) that had exactly that. In no time I had an instance set up[^1] and when I saw this

![/posts/n8n.png](/posts/n8n.png "Active Workflows: 2 of Unlimited")
*Freedom!*

had a huge sigh of relief. I could fuck this up seven ways from Sunday and it wasn't gonna cost me a god damned thing. Will it be harder and dumber than just learning how to use a handful of APIs and writing scripts in python? Probably yeah. Was I still able to retrieve data from [comicsrss.com](https://comicsrss.com) daily using a cron job, use regex to find the image url in the most recent item in a given RSS feed, and send that to a Discord webhook to be embedded into its own channel?

![/posts/n8n-pipeline.png](/posts/n8n-pipeline.png "The workflow described above. These images are much larger than I thought.")
*You betcha.*

Since I'm migrating everything over to the oceanetes cluster, it was easy to [use the n8n helm chart](https://github.com/8gears/n8n-helm-chart) and the Ingress configuration from [last time](https://tupperward.net/posts/adventures-in-labbing) to get a shiny new isntance up and running almost as little time as with docker-compose, only this time I have TLS!

## A Quick First Workflow

Making the workflow was easy enough. I  just pointed the RSS Read node to https://www.comicsrss.com/rss/heathcliff.rss. and then executed a bit of dumb js to find the image url. 

```javascript
var content = $input.first().json.content;
const regex = /https:\/\/assets\.amuniversal\.com\/(.*?)"/;
$input.first().json.url = content.match(regex)[0].slice(0, -1);
return [$input.first().json];
```

I think the trickest part of this is [setting up the Discord webhook](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks) but even that is pretty trivial. 

![It really is just that easy](/posts/garbage-ape-webhook.png "A quick screenshot of the Discord webhoook filled out.")

And let's do a quick test run...

![Working Webhook](/posts/garbage-ape.png "The webhook Garbage Ape posts the most recently daily Heathcliff comic")

Success![^2]

## Posting to Mastodon

Similarly, I'm setting n8n up to promote this blog using my Mastodon account. There is a community module in n8n for this, but I can't get the OAuth2 node to cooperate. Instead I opted for making direct HTTP requests to the `/api/v1` endpoint of the Mastodon instance as referenced in the [Mastodon API docs](https://docs.joinmastodon.org/methods/statuses/). 

To be honest, I couldn't find too much information about this regarding n8n and that was the impetus of this blog post. Well, that and making sure I don't get stagnant.

Using direct HTTP Requests to the API meant getting an `access_token` from my Mastodon instance, but setting that up in Developer settings took less than a minute. After receiving the `access_token` I was able to create a Header credential in n8n with the key `Authorization` and the value `Bearer <access_token>`. From there I just needed to send a `status` object in the body using JSON. Because I can use data from earlier in the workflow, I will be importing data from this website's RSS feed a lot like how we did in the first example. Here's what that HTTP Request node looks like in n8n.

![/posts/http.png](/posts/http.png "Filled out node details for an HTTP request as stated above")
*Christ on a cracker that's a long image. I gotta figure out image formatting in this.*

The end result is output that is a bit generic right now, but we can always expand on.

> Check out my newest blog post Adventures in Labbing: Part 2 - Adventures in n8n.
>
> https://tupperward.net/posts/adventures-in-n8n/
>
> #blog

Not that shabby! I would like to add a description field so I can get a little more robust with these automated messages, but this is a really suiting first start.

Next up: Jenkins for CD of this very blog!

[^1]: without TLS shhhh. Now we don't have that problem. We're big kids now.
[^2]: Look, I'm not going to ping the server at odd hours to do dumb shit for a dumb blog post. I mean I guess it's not pinging it's in its own channel, and nobody is tagged...whatever deal with a stale picture. 