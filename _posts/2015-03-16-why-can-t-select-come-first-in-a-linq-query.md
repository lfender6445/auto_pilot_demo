---
layout: post
title: "Why can't select come first in a LINQ query?"
description: ""
category:
tags: []
---

Why can't select come first in a LINQ query?


> What is the reason behind this restriction?

I believe the primary reason was actually Intellisense. Until an IDE knows what sort of collection you're using, it can't suggest which properties you want to use from the elements of that collection. The way the syntax works now, by the time you're writing a `select` or `where` clause, the IDE can tell what the element type is and make suggestions.

I would say it also has the benefit of making a lot more sense by putting the query in chronological order: you start with a source, filter it, transform it etc and end up with a result.

Finally, I suspect it makes the language transform from query expressions into "normal" C# (typically using extensions methods) simpler to express.

I think it would be more reasonable to ask why SQL is expressed backwards :)


In a LINQ query, the order of operators is `from`-`where`-`select`:

    int[] numbers = new int[7] { 0, 1, 2, 3, 4, 5, 6 };
    
    
    var numQuery = from num in numbers
             where (num % 2) == 0
             select num;

If we put the `select` clause first like in traditional `select`-`from`-`where` SQL, it fails to compile:

    var numQuery = select num // error: ; expected
             from num in numbers
             where (num % 2) == 0;

What is the reason behind this restriction?


