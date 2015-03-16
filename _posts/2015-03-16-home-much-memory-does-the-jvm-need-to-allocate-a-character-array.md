---
layout: post
title: "Home much memory does the JVM need to allocate a character array?"
description: ""
category:
tags: []
---

Home much memory does the JVM need to allocate a character array?


I believe you're observing [the way that the Oracle JVM allocates memory](http://www.journaldev.com/2856/java-jvm-memory-model-and-garbage-collection-monitoring-tuning).

In particular, the whole array has to fit into one "generation". By default, the old generation is twice the size of the new generation - which means for every 3MB you add in total, you only get 2MB of extra space in the old generation. If you change the ratio, you can allocate the char array in a smaller total size. For example, this works for me with your 512MB array:

    java -Xmx530M -XX:NewRatio=50 Test

As an aside, you see exactly the same effect with a byte array, and then you don't need to worry about doubling the length of the array to get the size in bytes. (There's the small constant overhead for the class reference and the length, but obviously that's trivial.)


Consider to following 1 line program:

    public static void main(String[] args) throws Exception {
  // 134217728 * 2 bytes / 1024 / 1024 = 256M
  char[] array = new char[134217728]; 
    }

How much memory does the JVM need to allocate this 256M character array?

Turns out the answer is -Xmx384m. Now lets try 512M character array...

    // 268435456 * 2 bytes / 1024 / 1024 = 512M
    char[] array = new char[268435456];

The answer appears to be -Xmx769m.

In running though a few examples for a character array of size m. The jvm needs at minimum 1.5m megabytes of memory to allocate the array. This seems like a lot, can anyone explain what is happening here?


