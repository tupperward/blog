---
title: "Nyetcooking"
date: 2025-12-08T16:35:12-05:00
tags:
  - coding
  - theft
  - cooking
image: /posts/nyetcook/cawcaw.jpg
featured: true
---
## TL;DR

I am coming back from the dead to unveil my new page, [Nyetcooking](https://worstwizard.online/nyetcooking), a page I initially created as a means of bypassing their paywall. This is actually a pretty useful little tool, which is a nice change of pace from making a shitty Gematria calculator and a [day calendar](https://sansculottid.es) for a system that's been disused for over two centuries.

## The Long Winded Story Before the Recipe

So I was minding my own business, trying to find a recipe for banana bread[^1] when I come across one NYTimescooking had hidden from me. I don't like that. I open up devtools on the page to see what layer I need to delete to see the rest of the rendered page, and lo and behold, there is already a wonderful little JSON object there with *all* the recipe data I need. As an engineer who hates frontend work, this excites me. Data? Structured?

With a JSON all I needed to get the recipe was a way to get the JSON object and then pass it into a Jinja template. First I wrote it in Go, since I waas in the middle of learning that for work. Turns out, Go is cool, but it's also not comfy yet. And since it isn't comfy, it turned out as a clunky CLI tool. Eventually, after trying to share it with some friends online, I realized what I needed to do.

Frontend development. Euugh.

I made everything into a Flask app and just ran with what I had already built. From there I stole the CSS styling from this site and made a 404 page. Bingo bango bongo, free recipes from just one website. Awesome! Now I (and maybe some other people) no longer need to give money to a print organization that provides cover for a genocidal regime! Neat!

## But That's Not All!

I tried to see if the regular NYTimes pages also follow the same pattern. As it turns out, no! They actually have bot protections on and even if they didn't, they likely don't provide a JSON slug with all the page data on it for me to consume. Why not?

When you're looking for news, you don't ask Alexa to search all news sources. You know which sources you think are reliable and you probably already subscribe to them in some manner. Recipes aren't like that. When you want banana bread, you do not care where the recipe comes from [^2], you mainly just care about having a good recipe. And so most recipe sites do not use any bot protections, because they *want* bots to scrape them and return traffic back. They *want* Alexa to grab the whole JSON slug so it can read it out to you.

And this focus on discoverability extends not just to NYTimes but also Allrecipes, Bon Appetit, Binging with Babish etc. They're all useing the Schema.org [Recipe](https://schema.org/recipe) schema, so this same logic works on *most* recipe websites! Not all of them, especially not those from smaller creators who have paywalled blogs. I made the choice that I don't care about stealing from [Babish](https://babi.sh), a man whose stylized face I see on knives at my local grocery store, and do care about not stealing from [Ethan Chlebowski](https://www.ethanchlebowski.com/), a guy who just cooks on YouTube. You should pay Ethan.

## Sharing is Caring

The only problem I had at this point was that the original page just cared about NYTimes recipes, so it was able to easily recreate the url to curl and re-cache the data as needed. So I just quickly changed this so that the path for nyetcooking recipes also recreates the full url from the original recipe, giving yourself a way to link back to it if needed. And then I added a printable page and a markdown page for those who also collect digital recipes.

And now it's done! Have fun finding stuff to cook! 

[^1]: It truly does not matter and you absolutely do not care.
[^2]: Sorta. I mean, if you're vegan or gluten free or something, you probably care more. But for those of use with fewer to no eating restrictions, not really.