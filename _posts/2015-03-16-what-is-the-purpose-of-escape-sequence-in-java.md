---
layout: post
title: "What is the purpose of Escape Sequence \' in java?"
description: ""
category:
tags: []
---

What is the purpose of Escape Sequence \' in java?


It's for use in character literals:

    char c = '\'';

Without that, it would be painful to get a single apostrophe as a `char`.


if I print ' (single quote) in the `System.out.println()` I can get exact output.

Like :

    System.out.println("test'test");
    output: test'test

What is the purpose of using \' escape sequence in java?

This also gives me the same output.

    System.out.println("test\'test");
     output: test'test

pls explain what is the main purpose of \' escape sequence in java


