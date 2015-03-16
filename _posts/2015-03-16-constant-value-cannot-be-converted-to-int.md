---
layout: post
title: "Constant value cannot be converted to int"
description: ""
category:
tags: []
---

Constant value cannot be converted to int


I can't see why line#5 fails to compile whereas line#4 is ok.

    static void Main(string[] args)
    {
  byte b = 0;
  int i = (int)(0xffffff00 | b); // ok
  int j = (int)(0xffffff00 | (byte)0); // error: Constant value cannot be converted to a 'int' (use 'unchecked' syntax to override)
    }


--------------------------------------- 
Compile-time constants are checked differently to other code, basically.

A cast of a compile-time constant into a type whose range doesn't include that value will always fail unless you _explicitly_ have an `unchecked` expression. The cast is evaluated at compile time.

However, the cast of an expression which is classified as a _value_ (rather than a constant) is evaluated at execution time, and handles overflow either with an exception (in checked code) or by truncating bits (in unchecked code).

You can see this slightly more easily using `byte` and just a `const` field vs a `static readonly` field:

    class Test
    {
  static readonly int NotConstant = 256;
  const int Constant = 256;
    
    
  static void Main(string[] args)
  {
      byte okay = (byte) NotConstant;
      byte fail = (byte) Constant; // Error; needs unchecked
  }
    }


