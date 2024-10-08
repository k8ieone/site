---
title: The GNOME Music Player Situation
description: I've just about had enough!
date: 2022-07-28
tags:
- technology
- gnome
- mpd
---

Alright, it's no secret that I like GNOME.
I like how the interface looks by default,
I like that they don't feel obligated to follow a traditional
Windows-like workflow.
I like that they're going for convergence between handheld and desktop devices
(and they're succeeding in that I think). Seriously libhandy is so cool!


Now why the frustration? My frustration comes from a pretty niche place I think.
I need a music player. Easy, right? `gnome-music` has you covered!


Well not really.
At the time of writing `gnome-music` doesn't adapt to a mobile layout at all,
which disqualifies it from being the music player of my choice for my PinePhone.
For that I found [Amberol](https://apps.gnome.org/app/io.bassi.Amberol/).
But that's too simple.
It can't run in the background and it doesn't have any kind of library view.


In addition to these issues, I have a problem
that neither of these two programs even attempt to solve.
I try to be a modern person (at least in this aspect) which means I stream my music.
Not from Spotify or anything like that, I use [Funkwhale](https://funkwhale.audio/).


Now, I looked at the source code of `gnome-music` and I almost started crying.
It's a Python program, which means I should be able to understand it
at least on a basic level and potentially hack-in
Subsonic/Funkwhale client fucntionality, right?
Well... It turns out the codebase for `gnome-music` is absolutely enormous.


But a bit of hope remains. I found out that `gnome-music` uses Grilo,
a plugin driven framework for sourcing media.
So it's simple, just make a Grilo plugin for Subsonic, right?
Well... Grilo is complicated to say the least.
It's almost entirely written in C.
What's more, I don't actually understand how it fits into media players.
There are some plugins that [don't really make sense to me](https://wiki.gnome.org/Projects/Grilo/PlannedFeatures).
After some research it turns out Grilo isn't really for making access to media easy.
It's about media **discovery**. This means it's probably just for sourcing metadata.
Although I's still not sure exactly, it's hard to tell
when there's a proposed Twitter plugin that is supposed to function as a full Twitter client.


So now what? From my research it's obvious that there isn't a project
that would be easily extensible yet modern (GTK4, libhandy, etc.).
Time to write my own then.


Before I invest huge amounts of time into learning GTK and UI design tho,
let's think about this.
I want something that wouldn't be as niche as just a Subsonic/Funkwhale player.
I'd like something that could adapt to things like Spotify, YouTube Music, etc.
so that others might find use for it as well.


Creating another music player would be pretty redundant tho, right?
There are so many out there already and I'd have to deal with GStreamer,
making a plugin standard and a whole bunch of other stuff I have no idea how I could ever manage to do.


I'm wondering, is there a player that already has a plugin system,
is battle-tested and widely used and is just lacking a GUI?


Of course! [Mopidy](https://mopidy.com/)!


As it turns out, there's not many GUI MPD clients out there.
Certainly not modern ones.


It seems like I found my solution then.
Just create an MPD client which uses GTK4 and all that other modern GNOME stuff.
Maybe I'll even try to follow the HIG, who knows?


That all comes later tho, first I need to get this project off the ground.
And I already did! Here's my first ever GTK4 program!

![smt](mphandy.png)

Alright, as you can tell, it needs... work... But I think I can get there eventually!
I'm calling it *mphandy* (I know, I'm terrible with names) for now, I just couldn't think of anything better.


Talking with MPD is very simple, the GUI is the part that will take most of my time (and sanity).


My only concern is that MPD is a bit limited.
It seems to me like there's no way to query anything else than its internal music database.
And external sources (like YouTube) are not indexed in it, because that would be ridiculous.


To my knowledge tho, there is no Python module to talk directly with Mopidy
(which would get around the search limitation).
I know there's [Iris](https://mopidy.com/ext/iris/) that has no problem searching sources like YouTube,
I'll have to see how they do it and maybe switch to that.
