---
title: "Windows Thoughts"
date: 2023-02-07T15:25:06-05:00
tags:
  - windows
  - wsl2
  - development
  - jots and thoughts
image:

---

I really haven't used my Windows machine much since getting the Mac for work. I should probably stop that, it's just...so much more convenient to use the Macbook in most cases. I mean, it certainly helps that it's portable and not tied to one desk location, but I'm usually at that same location using the same monitors for the Windows desktop.

I guess the problem is I mainly use this machine for gaming and since the baby I haven't really been able to dive into games like I used to. Maybe that will change, maybe not, but the one thing I do know for certain is I have been enjoying setting up this machine to use WSL 2 in as many cases as possible. I never really had to spend to much of my time developing anything specifically for Windows and I honestly can't imagine a world where that would happen anymore. With the power of containers it's kinda pointless to do anything but run Linux nodes and ship your software in a container. In the long run, I kinda expect to see the death of Windows development for the Enterprise.[^1]

That's kinda what I'm doing here on this machine. I have a VM in my Windows machine so I can use Debian instead of Windows for all the tasks I actually care about. I do have that one scrapped laptop I got from the repair shop but it's missing a power cable.[^2] But the point being, I basically just have venv for a whole machine inside Windows now. And I use that to make containers to send to other Linux machines. It's sick to not ever have to think about .NET or whatever it's called. It's awesome that I can manipulate files on Windows from WSL so I don't have to alias those damn Powershell commands.

Man, I just gotta make an Arch partition or something.

[^1]: Side note: I wonder how much longer Windows even has. We've seen corporate owned OS's die before, but I don't really see Windows regaining the prominence it had in the 90s. Most people don't even use a laptop or desktop in their day to day life anymore and Windows is kinda considered to be the less "premium" option of the two major keyboard-using OS's out there. Maybe this is finally the year of Linux desktop...

[^2]: This week I'm going to have to start a series about scrappernetes and the dumb shit I run with at home. That's really the fun stuff here.