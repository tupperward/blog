---
title: "Pathfinder 2E"
date: 2023-04-06T14:15:54-04:00
tags:
  - Pathfinder
  - OGL
  - TTRPG
image: /posts/pathfinder-image.jpg
comments: true
draft: true
---
---
I haven't cracked a D&D book since the OGL drama started a few months ago. While the dust has, ostensibly, settled on the issue I still think that this issue has come up twice now. D&D will get sold again and the new owner is just going to do the same thing. It's never, ever going to get better. [Paizo](https://paizo.com) has a much nicer model, in that all of their rules are entirely free. The thing they make their money on is the adventures and the "pawns." Now, I've played Pathfinder 1st edition for a while now and as someone who *started* with D&D 3.5, I *really really* Pathfinder 1st edition. It solves one of the biggest problems that 5e has, the lack of skill growth. This leaves skill based characters mainly just doing extra attacks and not much else which feels less than heroic during 2/3 of all types of encounters.

Back in 2020 I picked up a hardback copy of the Pathfinder 2E book and I hadn't looked into it too closely. At the time I had been part of a group that was about to start playing Starfinder, whose rules are much denser by comparison.[^1] Also I didn't like that one guy too much[^2] so I just didn't bother as hard as I could have. But recently I've [had an idea](https://www.youtube.com/watch?v=JXUPILVbAY0) that I want to work on until it's finished, a bit like the Repcal (more on Repcal updates later, too).

But going through the book, I've decided I really enjoy Pathfinder 2E and I'm excited to try it out. Here are some of my favorite changes from 5e.

# Things I Like
1. **The Rules Are Free. Even the Statblocks.** I'm a big open source guy, and I love it when rules are made open to the public for use. It's impressive what the Open Game License  ([and Paizo's upcoming ORC](https://paizo.com/community/blog/v5748dyo6si7v?Paizo-Announces-SystemNeutral-Open-RPG-License)) have been able to accomplish for making sure the people have access to the tools needed to actually play the game. You can just head right over to [pf2.d20pfsrd.com](https://pf2.d20pfsrd.com) to view the official SRD. You could also go to [aonsrd.com](https://aonsrd.com), a fan made site with a bit more casual readability that more closely replicates the actual content of the rulebooks.

1. [**Obsidian.md.**](https://obsidian.md/) Ok, this is just a note taking tool, but combined with the free SRD and [Herculean efforts of the community](https://www.patreon.com/posts/67310539), it can been turned into an absolute beast of a GM tool. Now I have a tool that has a searchable index of all the rules, monsters, spells everything in all official Pathfinder 2E books. Because Obsidian supports metadata tagging, the data query plugin allows meto easily search for creatures and design encounters so quickly (see the next item actually). I highly encourage you to explore this tool for managing your TTRPG needs whatever system you use.

1. **XP Budgeting.** Characters always level up when they get 1000 XP. This is handy for the player, sure, but holy *shit* is this handy for GMs. This flattens a lot of the dumb scaling math that used to go along with designing encounters and gives a much more streamlined feel. [XP Budgets](https://2e.aonprd.com/Rules.aspx?ID=498) will always use the same formula and that means that you can really easily [pick creature levels based on their XP](https://2e.aonprd.com/Rules.aspx?ID=498). If I have a party of 4 level 1's, and say I want a Moderately difficult encounter I would have an XP Budget of 80. I know I can get a level 1 creature that's at the party level and use up half that budget, maybe use this creature as a leader. Creatures that are Level -1 are 2 below the party so they're 20 XP each, which means I can fit two into our budget. Using my handy dandy data query tool I can pull up all the creatures that are Level 1 and Level -1 with "Kobold" in their name.
```
table level from #pf2e/creature/level/-1 or #pf2e/creature/level/1
where contains(name, "Kobold")
```

4. **Holistic Boss Planning.** This ties in again to the XP Budgeting system again! Let's say I find a monster I want to be my final boss fight. If the monster, let's say a Devil, is level 10 and you want the fight to be solo against the party, you know that it'd be 160 XP and that fits to about 4 levels above party level. That means the end fight should happen somewhere around level 6. This allows me to plan out the story beats a little more efficiently in the overall planning phase of the campaign.

5. **Bulk. Equipment Made Easy.** This came over from Starfinder and I love it. Bulk is a measure of weight/awkwardness to carry. One Bulk is about 5-10 lbs. Anything smaller than that is Light (L) and 10 Light objects are 1 Bulk. You can carry as much Bulk as up to 5 + STR mod without penalty and up to 10 + STR mod in total. So a 2 lb club is Light anda 2 lb quarterstaff is still 1 Bulk because it's a bit more unwieldy to carry and store..

6. **Spells Untied from Classes.** Spell traditions.

7. **Focus Points.** Boil it all down.

# Things I Don't Like

1. **There's a Lot of Paperwork** Every time you level up, your proficiency modifier for every one of your skills gets updated by at least 1. This is handy, but it's just one example of increased paperwork during the game, which is more upkeep and you know that's just going to lead to mistakes later.

1. **Core Rulebook Lacks Setting Details.** 



[^1]: The problem I'm currently having is how much I love the [Stamina/Resolve](https://www.aonsrd.com/Rules.aspx?ID=49) system for Starfinder. It's one that I think makes the most sense but unfortunately didn't make it over to PF2e, probably because it was so radically different.
[^2]: Fuck you, Mike, stop saying slurs. 
