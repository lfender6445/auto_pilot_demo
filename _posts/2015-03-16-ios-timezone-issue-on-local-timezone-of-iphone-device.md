---
layout: post
title: "iOS : Timezone Issue on Local timezone of iPhone device"
description: ""
category:
tags: []
---

iOS : Timezone Issue on Local timezone of iPhone device


The simplest approach would be to parse it as if it were UTC - making it _always_ valid, and without ever needing DST adjustments - and then format it in UTC as well. In other words, set the time zone of both the formatter and parser to UTC. For types which _need_ a time zone, that's the simplest way of faking "There isn't a time zone here, just treat it all as local to an unspecified time zone."


I have been working on an application that takes dates from server in a certain format as given below.

> **"2015-02-03 00:00:00"**

I want to show them with different UI format using **NSDateFormatter** but as i change the timezone it show previous day or sometimes next day as i changing timezone. One important thing that server side date can be in any of timezone. So, we don't know what kind of timezone date has. I need help to show this to the date as it is on server not change due to local timezone.

Thanks.


