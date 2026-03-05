---
title: Bringing Lightning to Quorra
summary: Taking Quorra in a new direction
date: 2026-03-05T00:12:36+01:00
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

Since "Quorra client" sounds technical, is a mouthful and is a bit ambiguous (Quorra client could also mean OIDC client), I'm standardizing a few terms.

I'm hoping this will make the Quorra ecosystem easier to navigate and simpler to grasp.

- Lightning wallet - an app many people already have; can now be used to log into Quorra
- Keychain - a minimal app for people who don’t want a wallet; login-only; no crypto
- Quorra server - the OIDC provider

Keychain applications are purpose-built just to allow you to log in. Keychains can also have custom functionality speciffic to Quorra and better UX.

## Quorra adopts Lightning auth

We're lighting up the sky with this one!

### What does that mean?

"Lightning auth" here is just a standardized way to prove you control a key. It's usually implemented by Bitcoin Lightning wallets. No payments are involved with Quorra, it's just used as a standard.

- **Each website gets a different login key, automatically:** keys are deterministically derived per domain
- **Crypto users are able to use their existing Lightning wallet** (e.g. [Phoenix](https://phoenix.acinq.co/), [Zeus](https://zeusln.com/), [Misty Breez](https://breez.technology/misty/)) with Quorra
- **No change for existing Quorra users:** keychain applications continue to work for non-crypto users
- **Moving to a new device can be as easy as restoring a backup phrase:** this uses a standard [BIP39 mnemonic code](https://cryobackup.com/pages/bip39-list)
- **Keychain apps can be used on other LNURL-auth services:** this is particularly great for Lightning node operators using NWC; LNURL-auth usually doesn't work over NWC which forces users to have two wallet applications - one for auth, one for everything else

The goal is to be neutral and unbiased to users. I don't want to shove crypto into people's faces or tell them to use a crypto wallet just to log in. My goal is to provide options.

### Why?

When I started Quorra, I implemented my own custom logic for keychain <-> server communication. This was mainly so that I could quickly prototype features and get my hands dirty.

I also didn't want to deal with the potential limitations of an existing protocol.

Now that the project has gained a bit of maturity, I think it's time to consider existing options to stop reinventing the wheel. LNURL-auth ticks all the boxes for me

- Simple to use
- Allows both QR and URI handling
- Extensible (custom parameters are ignored by wallets, allowing custom logic to be applied by keychain apps)
- Already well-established

LNURL-auth was a huge inspiration for starting Quorra. Now I'm extremely excited to announce LNURL-auth support in Quorra!

## Reworked onboarding and auth front-end

The onboarding frontend now gives a brief overview of what Quorra allows the user to do

TODO: Show

The frontend is now subtly animated

TODO: Show

The frontend now shows the OIDC application friendly name and URL

Insecure (HTTP) redirects show a visual warning

TODO: Show

The frontend now adapts to the user's theme preference (dark/light)

TODO: Show

As well as to the OS accent color (where supported by browser and OS)

TODO: Show

## What to expect in the future

My plan 
