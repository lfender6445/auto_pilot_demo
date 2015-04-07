---
layout: post
title: "Current time in millisecond in MYSQL"
description: ""
category:
tags: []
---

Current time in millisecond in MYSQL


How to get the current time in millisecond in MySQL.

So far what I've got is `UNIX_TIMESTAMP()`.

**But it returns the current time in seconds.**

But I want the current time in **milliseconds** in UTC since '1970-01-01 00:00:00' in MySQL.

_Any suggestion?_


--------------------------------------- 
Looking at the [documentation](http://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_now), it sounds like you want

    NOW(3)

... where the value 3 is used to specify that you want 3 digits of subsecond precision, i.e. milliseconds. (Unfortunately none of the examples in the docs show that being used, so it's relatively tricky for me to check this...)

To get that as a "milliseconds since the Unix epoch" value, you'd probably want to use:

    UNIX_TIMESTAMP(NOW(3)) * 1000


