---
layout: post
title:  "A Few Notes on Floating Point"
date:   2024-02-20 12:01:00 -0400
usemathjax: true
---

This post is a collection of tips for corralling floating point calculations,
particularly when implementing numerical programs. I will be referring to C++
documentation here but most of these notes should apply to any language with a
decent math library.

## C++ Standards

The newer C++ standards have provided added support as well as new built-in
functions for numerical calculation:

1. C++ now has a lot of built-in “special” functions that may allow you to
   simplify your code, including Hermite, Laguerre, and Legendre polynomials.
   Note that some of these implementations may be more efficient or less prone
   to floating point error (or both!) than the usual hand-coded equivalents.\
   See: [https://en.cppreference.com/w/cpp/numeric](https://en.cppreference.com/w/cpp/numeric)\
   And: [https://en.cppreference.com/w/cpp/numeric/special_functions](https://en.cppreference.com/w/cpp/numeric/special_functions)

2. There is now a floating-point environment that will allow you to detect
   floating point exceptions such as divide by zero, underflow, overflow, etc.\
   See: [https://en.cppreference.com/w/cpp/numeric/fenv/FE_exceptions](https://en.cppreference.com/w/cpp/numeric/fenv/FE_exceptions)

3. Use the infinity constant to represent numbers larger than any representable
   floating-point number. No more defining `BIG_NUM` as `MAX_FLOAT`. \
   See: [https://en.cppreference.com/w/cpp/types/numeric_limits/infinity](https://en.cppreference.com/w/cpp/types/numeric_limits/infinity)

4. Use `NaN`s. Really. If `NaN`s show up in your code, they can easily pollute
   calculations and therefore be hard to pinpoint. To address that, `NaN`s can be
   constructed and named. These named `NaN`s can then be injected and traced
   through your application, hopefully highlighting the source of the original
   problem.\
   See: [https://en.cppreference.com/w/cpp/numeric/math/nan](https://en.cppreference.com/w/cpp/numeric/math/nan)

## fma

Modern C++ also has a function called `fma` which is short for “fused
multiply-add.” In addition, it does this calculation to infinite precision then
rounds it to the specified return type. On many architectures, this is
implemented as a compiler intrinsic. On the rest, it will be emulated (and
therefore much slower, so be careful). Given the intrinsic support, it should be
available in languages beyond C++ (including Rust). In the blog post below, the
author uses the example of calculating 2x2 determinants, which show up in many
calculations. If you’re clever, you can build up a simple numerical library that
uses `fma` at its core.

In terms of performance, for floats `fma` is about 9% less efficient (1.09x)
and for doubles `fma` takes almost three times as long (2.98x).

See:
[https://pharr.org/matt/blog/2019/11/03/difference-of-floats.html](https://pharr.org/matt/blog/2019/11/03/difference-of-floats.html)\
See:
[https://en.cppreference.com/w/cpp/numeric/math/fma](https://en.cppreference.com/w/cpp/numeric/math/fma)

## Herbie

Herbie (links below) is an open source program that will take an input
floating-point expression and output an equivalent expression (sometimes over a
smaller domain) that minimizes floating-point error. I suggest trying:
* An expensive operation: $$\sqrt{x+1}-\sqrt{x}$$
* Some known polynomials: $$j0(x+1)-j0(x)$$ (This used to work?)
* The quadratic formula
* Any trig formulas

Note that sometimes Herbie delivers a much more complex expression than the
input. Sometimes it even outputs a constant-valued approximation over a much
smaller domain of the reals! You should balance your implementation on accuracy,
readability, and overall maintainability.

Herbie live demo:
[https://herbie.uwplse.org/demo/](https://herbie.uwplse.org/demo/)\
Herbie source: [https://github.com/uwplse/herbie](https://github.com/uwplse/herbie)
