---
layout: post
title: "PHP DateTime converting issue"
description: ""
category:
tags: []
---

PHP DateTime converting issue


I think I've got it. The problem is that you're not specifying a time of day, so [`createFromFormat`](http://php.net/manual/en/datetime.createfromformat.php) is using "the current system time":

> If format does not contain the character ! then portions of the generated time which are not specified in format will be set to the current system time.

Now what does it mean to use "the current system time" to create a time in the New York time zone, when that time zone has changed UTC offset between the specified date (March 1st) and the current date (March 14th)? It was UTC-5 on March 1st, and it's now UTC-4 due to daylight saving time.

I believe PHP is taking the current time of day in the specified time zone (9:16 at the time you ran that code) and then using that as the time of day on the specified date. So we end up with March 1st 2015, 09:16 New York time - or March 1st, 14:16 UTC, which is indeed March 1st 17:16 Moscow time.

That's not the same as the current time of day in Moscow at the time that you ran the code, which was 16:16.

Basically, you should try not to do this - or expect problems like this to happen. Think about what time of day you're _really_ trying to represent, bearing in mind that within a particular time zone, offsets change over time. I can't really advise you on what your code _should_ be, because we don't know what you're trying to achieve - but using the current time of day _for a different date_ can definitely cause this problem.


I have an issue with converting DateTime from Moscow timezone to New York timezone. Here is my test script:

    $year = 2015;
    $month = 3;
    $tzMoscow = new DateTimeZone('Europe/Moscow');
    $tzNewYork = new DateTimeZone('America/New_York');
    $startDate = DateTime::createFromFormat('Y-n-d', "$year-$month-01", $tzMoscow);
    echo $startDate->format('Y-m-d H:i:s')."\n"; // 2015-03-01 16:16:05
    $startDate = DateTime::createFromFormat('Y-n-d', "$year-$month-01", $tzNewYork);
    echo $startDate->format('Y-m-d H:i:s') . "\n"; // 2015-03-01 09:16:05
    $startDate->setTimezone($tzMoscow);
    echo $startDate->format('Y-m-d H:i:s') . "\n"; // 2015-03-01 17:16:05

Third output is incorrect, time should be 16:16:05. Am I doing something wrong or is this a bug in php?


