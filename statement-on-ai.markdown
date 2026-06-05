---
layout: page
title: Statement on AI
permalink: /on-ai/
last_updated: 2026-06-03
---

<p style="font-size: 14px; color: var(--ctp-subtext1); font-style: italic;">Last updated: {{ page.last_updated | date: "%B %-d, %Y" }}</p>

### TL;DR

All of the software built in this blog was, and will be, built with agentic AI. All prose on this blog is entirely my
own.

Overall, I think the genie is well out of the bottle. My goal is to leverage agentic AI to create novel software
artifacts and research.

My thesis is that code itself is a low-value and time-consuming artifact whereas the true value of software is the
human <i>understanding</i> behind it.

### How I Am Building

In general, for all of the open-source software artifacts in this blog (including the blog <i>code</i> itself), I am
letting my AI agents have free rein in development and testing. I demand comprehensive automated test suites but only
lightly audit their contents. I do light code audits periodically and read code snippets that I find interesting. I am
not doing full-on code reviews for what gets emitted by the agents. This is all done in the interest of speed.

In my own practice here on this blog, the concern is simple and honest: I am not verifying every single line of what I
push to my repositories. I can all but guarantee I am shipping hallucinations, one way or another.

That said, I am a 20+ year veteran with strong coding and graphics chops. I want to understand where and how these
systems break or ship garbage. I hope that what you find in the posts that I write is an honest account of what worked,
what didn't, and what I think comes next. I also hope that you find that I take the time to explain the core ideas of
each post and where they could lead.

One of my hopes with AI is that it will truly free up talented people to do more creative work. I no longer feel a
massive time burden in building large, complex software packages. Surely that time can now be better spent inventing the
future by crafting the next great ideas in human minds and letting AI build the actual artifacts.

I share all of the macro concerns noted by many: that this has created a potential financial bubble over the last few
years, that this will continue to consolidate power and wealth into the class that owns these powerful tools, that this
will incentivize those in power to reduce workforce, not increase it, and that the opacity of these models may infringe
upon the work of many without their consent.

### Loose Thoughts

The consequences of these tools are both broad and profound. New revelations come to me frequently. My goal is to record
them here, mostly for my own reference as we move into the future.

1. If humans aren't writing code anymore, is there value in humans <i>reading</i> code anymore? I could see a world
   where compiled languages simply disappear and agents write something closer to machine code directly.
2. I believe the economic value of code was nearly zero before agentic AI. The true value of any code is the mental
   model that resides in the minds of the developers who wrote it. However, the value of code in a post-agentic AI
   world is clearly slightly above zero, roughly some fractions of a cent for the power needed to train and run
   inference on the models. Code is now a commodity and a cheap one at that.
