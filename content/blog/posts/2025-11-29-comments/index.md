---
title: Now with Comments!
summary: I'm adding a comment widget to some of my posts!
date: 2025-11-29T00:06:20+01:00
lastmod: 2025-11-29T00:06:20+01:00
tags:
- site
params:
  comments: true
---

You can see it at [the bottom of this post](#footer) and it might start popping up on posts where I think it makes sense to have comments.

It's deliberately collapsed by default for two reasons:

1. To avoid distracting the reader while they read the article
2. To avoid visual clashing - the widget's styling is an extremely poor fit for the site

The widget is powered by [Coral](https://coralproject.net/) and hosted on **my own infrastructure**.

In order to comment you **have** to register. Sadly there seems to be no option to allow anonymous comments, but at least you can delete your account at any time through the account settings.  
I also found that the email address you put in doesn't have to be real - you can comment right after you click register. Not that I recommend using a fake address because you'll lose the ability to reset your password and receive notifications.

Other than the lack of some options and the dated look, I'm quite happy with Coral.

I found some more options [here](https://lisakov.com/projects/open-source-comments/), but most of them don't meet my requirements:

1. Self-hostable
2. Production-ready database - Postgres/MariaDB/etc. **NO SQLITE!**
3. Self-registrations or anonymous comments
4. Optional: OIDC login

Most comment systems focused on static sites seem to prioritize ease of deployment and light footprint over resilience and scalability.

So far I like [Discourse](https://discourse.org/) the most, but it's is quite heavy and complicated to get going... Not like that has ever stopped me from hosting a service but it's *really* overkill to host Discourse just as a comments system for a site.

In the future the comments widget might get replaced by a different one or get removed completely. We'll see how things go.
