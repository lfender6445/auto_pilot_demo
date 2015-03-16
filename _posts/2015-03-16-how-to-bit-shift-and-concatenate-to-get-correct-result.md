---
layout: post
title: "How to bit-shift and concatenate to get correct result?"
description: ""
category:
tags: []
---

How to bit-shift and concatenate to get correct result?


I'm currently struggling with modbus tcp and ran into a problem with interpreting the response of a module. The response contains two values that are encoded in the bits of an array of three `UInt16` values, where the first 8 bits of r[0] have to be ignored.

Let's say the UInt16 array is called `r` and the "final" values I want to get are `val1` and `val2`, then I would have to do the following:

![6](http://i.stack.imgur.com/SG7Xa.gif)

In the above example the desired output values are `val1` (=3) and `val2` (=6) for the input values `r[0]`=768, `r[1]`=1536 and `r[2]`=0, all values as UInt16.

I already tried to (logically) bit-rightshift `r[0]` by 8, but then the upper bits get lost because they are stored in the first 8 bits of `r[1]`. Do I have to concatenate all r-values first and bit-shift after that? How can I do that? Thanks in advance!


--------------------------------------- 
> I already tried to (logically) bit-rightshift r[0] by 8, but then the upper bits get lost because they are stored in the first 8 bits of r[1].

Well they're not "lost" - they're just in r[1].

It may be simplest to break it down step by step:

    byte val1LowBits = (byte) (r[0] >> 8);
    byte val1HighBits = (byte) (r[1] & 0xff);
    byte val2LowBits = (byte) (r[1] >> 8);
    byte val2HighBits = (byte) (r[2] & 0xff);
    
    
    uint val1 = (uint) ((val1HighBits << 8) | val1LowBits);
    uint val2 = (uint) ((val2HighBits << 8) | val2LowBits);


