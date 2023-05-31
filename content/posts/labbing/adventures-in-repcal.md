---
title: "Adventures in Labbing - 'Repcal'"
date: 2023-05-30T23:46:15-04:00
tags:
  - adventures in labbing
  - french republican calendar
  - Kubernetes
image: /posts/decimal-clock.jpg
comments: true
---

I made a fun little website called [sansculottid.es](https://sansculottid.es) all about the French Republican Calendar. If you're not familiar with the calendar and why I think it's cool, go immediately read Ursula Lawrence's excellent [introduction to her French Republican Wall Calendar](https://www.ursulalawrence.com/the-french-republican-wall-calendar).[^1] Her calendar's focus on the natural elements really drew me in, and I really think this part stands out.

>The authors of the original calendar thought carefully about when to honor each item. If they did it right, this version should at least be somewhat predictive of what will come into season when. For example, rhubarb almost always appears in the grocery store within a week of Rhubarb Day. Tulips, violets, and lilacs also tend to appear in sync. And for those of us living in northern climes, there is something truly appropriate about assigning coal, peat, and manure (yes, manure) to the depths of January.

This project started after [I used n8n to post comics to Discord every day](https://worstwizard.net/posts/labbing/adventures-in-n8n). After adding Webhooks for Nancy and Heathcliff and a ton of other junk I decided I should really apply a lot more effort to annoying my friends and family with unwanted information related to my special interests. What I really wanted was a daily calendar app, sorta like [@sansculotides](https://twitter.com/sansculotides)'s posts. This was originally a Twitter account, which still exists, but due to that platform's increasing instability there was a bit more impetus to make an alternative. At the time I hadn't really looked too far into Mastodon or the Fediverse and didn't know that [@sansculotides@botsinspace](https://botsin.space/@sansculotides) had already migrated to a more durable platform.

Because of the previous n8n project, I had initially conceived of this project in terms of setting up just an RSS feed with the needed data. I spent forever fighting with python's feedgenerator library before pulling the plug. I eventually figured out how to simply post the information about the current day to a web page. I had been playing with Flask recently and decided to paste things together. Let's be clear, this is babby's first website for sure. What I think is interesting is the infrastructure I used. 

In order to practice with discord.py a bit after its near overhaul, I decided to use it to make a Webhook that scraped the webpage I had made. That was extremely easy. I packaged it into a container image and made a kubernetes CronJob that ran that container on a schedule. When that eventually broke, I decided to make a /data endpoint that just has a json of the object I created. I redesigned the webhook container to just read the json data instead of scraping HTML.

Here's the fun part. I realized at this point that I could open this up to everybody. I was a able to use python's kubernetes library to generate additional CronJobs defined by some user input at the /signup page. Now anybody with access to create a webhook in their Discord server can similarly have this delivered right to friends notfications bars. Get as annoying as possible!

[^1]: My wife actually gifted me a copy of this calendar a couple years back and it's maybe one of my favorite posessions, so if you're interested I cannot recommend finding one for yourself. If not, boy have I got great news about a brand new website that you just heard about.