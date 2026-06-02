---
title: Rebuilding for a Post-Trust World
summary: We need to do a better job of securing our desktops.
date: 2026-05-29T15:46:14+02:00
lastmod: 2026-06-02T10:43:43+02:00
tags:
- technology
- personal
params:
  comments: true
  display_toc: true
---

Several factors -- including the LLM craze, the increase in Linux's popularity as a desktop OS, the almost unanimous use of Linux in the cloud and on servers -- are causing attackers to shift focus onto the unsuspecting FOSS community.

The recent attacks and vulnerabilities made me realize that the way most people use Linux desktops is **absolutely not ready** for simple malware, let alone dedicated malicious actors.

This was a very chilling realization for me and since that day I feel like every time I update my system, I risk becoming a victim of one of these attacks. More importantly there's nothing protecting me except for volunteers' spare time and the [very few companies](https://openssf.org/about/members/) putting money into FOSS security.

> [!NOTE]
> The company list isn't exhaustive. There are companies doing their own independent security research and contributing in their own way.  
> However I still think there are **a lot more** companies that use FOSS software and simply don't contribute to its safety and security **at all**.


If you think I'm exaggerating or just being paranoid, take a look at these supply chain attacks from just the few past months:

- https://docs.litellm.ai/blog/security-update-march-2026
- https://safedep.io/mass-npm-supply-chain-attack-tanstack-mistral/
- https://safedep.io/mini-shai-hulud-strikes-again-314-npm-packages-compromised
- https://safedep.io/redhat-cloud-services-hit-by-mini-shai-hulud-npm-worm/
- https://safedep.io/malicious-node-ipc-npm-compromise

Even more concerning is the rise of vulnerabilities like [copy.fail](https://copy.fail) and [DirtyFrag](https://github.com/V4bel/dirtyfrag). When combined with e.g. [Nginx-Rift](https://github.com/DepthFirstDisclosures/Nginx-Rift) -- an 18-year-old remote code execution vulnerability in Nginx -- it gives attackers zero-click remote root access, even if using the very sandboxing techniques I'm about to discuss!

If you told me that I need to protect against a single dedicated person who **might try** to compromise me and specifically **my** system, I would tell you that I'm simply not valuable enough of a target to warrant the effort. But when what we're dealing with are these wide-net automated attacks, I suddenly don't feel all that confident. And only trusting volunteers to uncover every one of these attempts fast enough to prevent damage seems unwise at best.

I'm not trying to say volunteers can't do a good job at making their projects secure but if you put a state-sponsored bad actor with virtually unlimited resources up against a bunch of people who work on their projects in their spare time, who do you think has a better chance of winning?

This post is getting grim and I think I made my point. We shouldn't just blindly trust whatever we run on our systems. Let's put a few obstacles in the attacker's way!

> Get ready for a major remodel, fellas! We're back in hardware mode!
> - Tony Stark, https://youtube.com/watch?v=y0brSA1cyzw

My plan involves several layers…

## Minimize the OS

### The Plan

The operating system is going to serve as a minimal base for running sandboxed applications. The number of non-sandboxed workloads that run directly on the host OS should be kept to a bare minimum. This is to prevent the amount of code and dependencies that have access to the host's filesystem.

I chose Arch Linux installed using `bootc` for this task. `bootc` is a relatively new project, originally used by projects like [Fedora CoreOS](https://fedoraproject.org/coreos/) and later [Fedora Atomic Desktops](https://fedoraproject.org/atomic-desktops/). Now thanks to the `composefs` backend and the folks at [bootcrew](https://github.com/bootcrew/mono), you can run operating systems other than Fedora using `bootc`.

I use `bootc` in a way that doesn't allow any changes to the OS at runtime. All changes to the system require an image rebuild, including `pacman` operations. This makes sure I have a complete overview of the packages that run on the host.

It also serves as a deterrent for me! I'm lazy and installing things as a system package is often faster than dealing with sandboxing. `bootc` flips things around - full system rebuilds are fairly annoying to do, which I consider a feature in this case. It forces me to try using Flatpaks or Docker containers first.

Yet another effect is that it stops `/etc` configuration drift. Because `bootc` allows users to configure `/etc` as read-only, I have to configure my system while the image is being built. I already handle my user config files using git and Ansible, so this perfectly fits into my setup. Yay!

### The Reality

I'm still evaluating the real-world usability of a `bootc` system. There are a bunch of things that I still need to try out.

1. Compatibility with BIOS systems - I still have a few laptops with BIOS-only booting and `bootc` only seems to work with the UEFI-exclusive systemd-boot
2. Disk encryption - there is no native installer to install custom `bootc` systems and I haven't yet tested putting the system onto an encrypted partition

It's also worth noting that `bootc`'s `composefs` backend is still marked as an experimental feature. So I'm still building up confidence in it and slowly trying how it handles real-world usage.

## Flatpakize!

Most desktop applications I use already have a Flatpak and I tend to use them instead of native packages so I don't really have much to do here.

It is important to check which permissions are granted to the installed applications. There was a time where practically every application had very wide permissions (e.g. access to the whole home directory). This has significantly improved with time. These days you rarely see Flatpaks that require wide permissions.

To inspect the permissions of your Flatpaks, you can use [Flatseal](https://flathub.org/en/apps/com.github.tchx84.Flatseal).

I feel like it's important to shout out Flatpak here because it is one of those projects that seems to know what they're doing and what they need to do.

I feel like the work on portals and integration with Wayland and PipeWire is exactly the right way to do things. The fact that an application is allowed to show a window on your computer screen doesn't mean that it is trusted.

Portals, Flatpak, Wayland and PipeWire create this "zero-trust-like" environment and I love them for it.

When I first tried Flatpak ~2018, it was kind of a mess. Applications didn't work the way they were supposed to work, `filesystem=host` everywhere. Now things just work.

## Dockerize!

But what if things can't really work with Flatpak?

There are a few applications where Flatpak isn't exactly the best fit. I see this mainly with applications that need to interact and connect with other applications.

To fill those gaps and avoid resorting to installing things on the host, I plan to use Docker containers.

I have two examples that just don't play nice with Flatpak:

### Firefox

Yes, you read that correctly!

Browsers have had Flatpaks for ages now but I **still** don't use browser Flatpaks. Why?

Native messaging.

If you're not aware, browsers have a feature called native messaging. It allows a browser extension to call a binary on the host in order to perform an action outside of the browser. I don't want to go into unnecessary details here so you can learn more about this [here](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_messaging).

I use `pass` as a password manager and its browser extension needs to be able to reach out of the sandbox and call `pass` to to decrypt passwords. Flatpak has a solution for this, called [xdg-native-messaging-proxy](https://github.com/flatpak/xdg-native-messaging-proxy) but it hasn't been adopted by any browser yet.

For this reason I'm likely going to run Firefox with `pass` inside a Docker container. It worked surprisingly well when I tried it out. And it's easy to get going as well!

You can try it yourself in fact!

```bash
docker run -it -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
 -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
 -v $XDG_RUNTIME_DIR/pipewire-0:$XDG_RUNTIME_DIR/pipewire-0 \
 -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY \
 archlinux:latest
pacman -Sy firefox
firefox
```

If you're on a Wayland system with PipeWire, Firefox should open right up on your desktop!

It works as a demo but I haven't tried daily-driving it yet. I'll have to spend some more time on trying this out.

### `zdev`

I recently created a DIY "IDE" (called `zdev`) by tightly integrating Yazi, Zellij, Helix, [mdfried](https://github.com/benjajaja/mdfried) and various other tools. I need all those tools to live alongside each other and talk to each other.

For this reason I started looking into using Docker for running `zdev`.

I have a small script on my host which creates a new container for every `zdev` instance I start. It mounts its current working directory into the container and my entire development environment lives inside a container!

I haven't completely finished rewriting `zdev` to work nicely with containers, but I have been daily-driving my proof-of-concept Dockerized version for a few weeks now without any major issues.

I plan to release `zdev` as FOSS after I finish splitting it from my dotfiles repo.

## The Future

This security remodel is my primary focus now. To be honest, I’d rather be working on some of my other projects, but this is some serious technical debt that I feel like I need to address. For this reason, I likely won't return to my projects until I’ve solved these core security issues.

I plan to release the non-sensitive parts of my new setup (e.g. `zdev` as mentioned before) as FOSS, but don't expect any complete universal solutions. Currently I'm making things work **for me**, not for others.

## Reality Check

I'm well aware that all this achieves is making the attacker's job harder and potentially minimizing damage. But it's the best I can currently do.

And it's waaaaay better than giving **every** program on my computer access to the entire filesystem, that's for sure.

Obviously it's not all bulletproof. Like mentioned at the start, kernel vulnerabilities can still cause sandboxing to be completely ineffective.

The goal is to be better, not perfect.

## Article Revisions

- July 2nd, 2026 - added [another supply chain attack](https://safedep.io/redhat-cloud-services-hit-by-mini-shai-hulud-npm-worm/)
