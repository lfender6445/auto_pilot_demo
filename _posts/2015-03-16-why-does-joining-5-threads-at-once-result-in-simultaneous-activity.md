---
layout: post
title: "Why does joining 5 threads at once result in simultaneous activity?"
description: ""
category:
tags: []
---

Why does joining 5 threads at once result in simultaneous activity?


    Thread.new{sleep rand(0..10}; puts '#1 done'}.join
    Thread.new{sleep rand(0..10}; puts '#2 done'}.join
    Thread.new{sleep rand(0..10}; puts '#3 done'}.join
    Thread.new{sleep rand(0..10}; puts '#4 done'}.join
    Thread.new{sleep rand(0..10}; puts '#5 done'}.join

This will result in thread 1 being executed to completion before thread 2 begins. I will always get the output 1-2-3-4-5 and the batch can take up to 50 seconds.

    t1 = Thread.new {sleep rand(0..10); puts 'Thread 1 done.'}
    t2 = Thread.new {sleep rand(0..10); puts 'Thread 2 done.'}
    t3 = Thread.new {sleep rand(0..10); puts 'Thread 3 done.'}
    t4 = Thread.new {sleep rand(0..10); puts 'Thread 4 done.'}
    t5 = Thread.new {sleep rand(0..10); puts 'Thread 5 done.'}
    [t1,t2,t3,t4,t5].map(&:join)

This, however, results in all 5 threads being executed in parallel; each time I will get a random output order and the entire batch takes no more than 10 seconds.

My question is: Why?

My understanding is that `map` will go through each item in the array and execute the `Thread#join` method on each one in turn... which is exactly what my first code example does. So I would expect totally identical results, yet there's clearly some difference there.


--------------------------------------- 
> My understanding is that map will go through each item in the array and execute the Thread#join method on each one in turn... which is exactly what my first code example does.

No, it isn't.

The first code starts a thread, then joins it - and _then_ starts the next thread, joins it, etc. There's no parallelism involved:

    Start thread 1
    Join thread 1
    Start thread 2
    Join thread 2
    Start thread 3
    Join thread 3
    Start thread 4
    Join thread 4
    Start thread 5
    Join thread 5

The second code starts _all_ the threads, then joins _all_ of them. So when the first `join` call is executed, all the threads are running, rather than just the one extra one.

    Start thread 1
    Start thread 2
    Start thread 3
    Start thread 4
    Start thread 5
    Join thread 1
    Join thread 2
    Join thread 3
    Join thread 4
    Join thread 5

Do you understand why those are different?


