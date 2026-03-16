---
title: Bringing Lightning to Quorra
summary: Taking Quorra in a new direction
date: 2026-03-05T00:12:36+01:00
lastmod: 2026-03-15T10:33:29+01:00
draft: true
params:
  display_toc: true
  comments: false
tags:
- technology
- quorra
---

Welcome to the first Quorra update! I have a number of exciting updates to share, so please, read on.

## Standardized wording and terms

Since "Quorra client" is technical, ambiguous, and a mouthful, I'm introducing a new term for them: **keychains**!

- Lightning wallet - an app many people already have; can now be used to log into Quorra
- Keychain - a minimal app for people who don’t want a wallet; login-only; no payments; no currencies
- Quorra server - the OIDC provider which uses LNURL-auth

Keychain applications are purpose-built for login. Keychains can also have Quorra-specific features and can provide UX not normally possible on wallets.

I'm hoping this will make the Quorra ecosystem easier to navigate and simpler to grasp.

## Voucher becomes referential

With the refined wording comes a new exciting change for [Voucher](https://github.com/k8ieone/voucher)! Voucher now serves as the reference keychain implementation.

This means that Voucher represents the features and UX that all keychains should strive to have.
This also means that Voucher will be the first to receive new features and will likely see the most development time of all first-party keychain applications. 

TODO: Show a Voucher screenshot

I'm hoping to create a "keychain feature checklist" for developers once I've prototyped and stabilized them in Voucher.

## Quorra adopts Lightning

We're lighting up the sky with this one!

### What does that mean?

**Lightning auth** (LNURL-auth) here is just a standardized way to prove you control a key. It's usually implemented by Bitcoin Lightning wallets. No payments are involved and you don’t need a wallet. Lightning is just used as a standard to build upon. Keychain apps remain a first-class option.

I don't want to shove crypto into people's faces or tell them to use a crypto wallet just to log in. My goal is to provide options without bias.

LNURL-auth has a number of benefits:

- **Each website gets a different login key, automatically:** keys are deterministically derived per domain
- **People who already use Lightning wallets don't need a separate app:** wallet applications like [Phoenix](https://phoenix.acinq.co/), [Zeus](https://zeusln.com/), [Misty Breez](https://breez.technology/misty/) are all automatically compatible
- **No change for existing Quorra users:** keychain applications continue to work for users who don't want to use wallets
- **Moving to a new device can be as easy as restoring a backup phrase:** this uses a standard [BIP39 mnemonic code](https://cryobackup.com/pages/bip39-list)
- **Keychain apps can be used for other LNURL-auth services:** this is particularly great for Lightning node operators using NWC; LNURL-auth usually doesn't work over NWC which forces users to have two wallet applications - one for auth, one for everything else

### Why?

When I started Quorra, I implemented my own custom logic for keychain <-> server communication. This was mainly so that I could quickly prototype features and get my hands dirty. I wanted to move fast without being constrained by a protocol too early.

Now that the project has gained a bit of maturity, I think it's time to consider existing options and stop reinventing the wheel. LNURL-auth ticks all the boxes for me:

- It's simple to use
- Allows both QR and URI handling
- Extensible: custom parameters are ignored by wallets, allowing custom logic to be applied by keychain apps
- Already well-established with a thriving ecosystem

LNURL-auth was a huge inspiration for starting this project and now I'm extremely excited to announce its integration into Quorra!

I'm hoping this will make Quorra simpler to use, easier to maintain long-term and allow it to integrate with existing tools.

## Reworked onboarding and auth front-end

The onboarding frontend now gives a brief overview of what Quorra allows the user to do

TODO: Show

The frontend is now subtly animated

TODO: Show

The frontend now shows the OIDC application name and URL

Insecure (HTTP) redirects show a visual warning

TODO: Show

The frontend now adapts to the user's theme preference (dark/light)

TODO: Show

As well as to the OS accent color (where supported by browser and OS)

TODO: Show

## What to expect in the future

When I have news to share, I'll post a new blog entry. Be sure to check the [Quorra category](../../tags/quorra) regularly or subscribe to it [using RSS](../../tags/quorra/index.xml)!

I also created a [board on GiHub](https://github.com/orgs/Quorra-Auth/projects/3) to track the current progress, but the board is fairly developer-focused.

The current (very rough) plan, as of {{< date_created >}}, is to:

- Implement key management into Voucher
- Get an icon for Voucher and publish it on Flathub
- A few more frontend improvements
- Get a live demo working
- Create documentation for running your own server
- Start implementing the self-service and admin interface!

See you in the next update!
