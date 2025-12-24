---
layout: post
title:  "The Geometry of Envelopes"
date:   2026-01-01 12:00:00 -0400
slug: the-geometry-of-envelopes
usemathjax: true
---

When I was a kid and was stuck in some place where I had nothing but pencil and paper to entertain myself, I'd often
draw a simple set of lines that sketched out a cool curve. One way to do this is quite simple draw line segments from (0,1) to (10,0), then (0,2) to (9,0), and so on:

<img id="envelope-diagram"
     src="{{ '/assets/diagrams/2026-01-01-the-geometry-of-envelopes/envelope-10-lines-latte.svg' | relative_url }}"
     data-light-src="{{ '/assets/diagrams/2026-01-01-the-geometry-of-envelopes/envelope-10-lines-latte.svg' | relative_url }}"
     data-dark-src="{{ '/assets/diagrams/2026-01-01-the-geometry-of-envelopes/envelope-10-lines-mocha.svg' | relative_url }}"
     alt="Ten line segments forming an envelope curve"
     class="theme-aware-diagram"
     style="max-width: 100%; height: auto;">

But what is this curve? The first few times I drew it I couldn't even guess. Some time later, I thought it either looked
like a horizontally-stretched parabola or a quarter circular arc with the circle center in the top right.

<img id="envelope-comparison"
     src="{{ '/assets/diagrams/2026-01-01-the-geometry-of-envelopes/envelope-comparison-latte.svg' | relative_url }}"
     data-light-src="{{ '/assets/diagrams/2026-01-01-the-geometry-of-envelopes/envelope-comparison-latte.svg' | relative_url }}"
     data-dark-src="{{ '/assets/diagrams/2026-01-01-the-geometry-of-envelopes/envelope-comparison-mocha.svg' | relative_url }}"
     alt="Comparison of envelope curve with parabola and circular arc"
     class="theme-aware-diagram"
     style="max-width: 100%; height: auto;">
