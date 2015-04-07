---
layout: post
title: "How to remove escape extra slash in java properties"
description: ""
category:
tags: []
---

How to remove escape extra slash in java properties


I am using the following to write some values to a .properties file. this code works with one small problem the value that gets written is like this

    C\:/MyDir/MyDir2/Downloads/SomeOrder.txt

With an extra slash, this does not work. For the life of me I can't get rid of the extra slash. I have tried URLEncode.encode but no go.

Thanks for any help.


--------------------------------------- 
That's fine. That's how it's _meant_ to be written to the properties file.

From the [`Properties.store`](http://docs.oracle.com/javase/8/docs/api/java/util/Properties.html#store-java.io.Writer-java.lang.String-) documentation:

> The key and element characters #, !, =, and : are written with a preceding backslash to ensure that they are properly loaded.

The code that _reads_ the value from the properties file will unescape it appropriately.


