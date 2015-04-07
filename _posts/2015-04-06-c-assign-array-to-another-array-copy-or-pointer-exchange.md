---
layout: post
title: "C#: Assign array to another array: copy or pointer exchange?"
description: ""
category:
tags: []
---

C#: Assign array to another array: copy or pointer exchange?


Sorry for asking this question, I have been Googling a bit but it seems what comes up is references to clone or copy methods, not an actual answer for my question in `C#`.

I have two arrays of bytes, and they are being accessed by two threads.

    private byte[] buffer1 = new byte[size];
    private byte[] buffer2 = new byte[size];

My goal is to write in `buffer1` in `Thread1`, grab a mutex, switch the pointers around and repeat the process. `Thread2` would grab a mutex and always read `buffer2`.

The goal is that `Thread2` runs fast and is not affected by the copy taking place in `Thread1`.

I am very unclear what happens when I do the following:

    byte[] temp = buffer1;
    buffer1 = buffer2;
    buffer2 = temp;

Are the pointers being switched or is the content of `buffer2` being copied to `buffer1`? It should be a simple question but I can't seem to find the solution. `Thread1` is doing a `Marshal.Copy()`, and I don't want the call to impact `Thread2`.


--------------------------------------- 
Assignment always just copies the value of one expression into a variable (or calls a property/indexer setter).

In your case, with this:

    buffer1 = buffer2;

... the value of `buffer2` is just a _reference_ to a byte array. So after that assignment (and assuming no other assignments), changed made to the byte array "via" one variable will be visible "via" the other variable.

This isn't specific to array types - this is how reference types work all the way through .NET:

    StringBuilder x = new StringBuilder();
    StringBuilder y = x;
    x.Append("Foo");
    Console.WriteLine(y); // Foo

It's just a matter of understanding that arrays are always reference types.


