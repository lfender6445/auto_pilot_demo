---
layout: post
title: "Is TimeZone.getDSTSavings() in java returns always positive value?"
description: ""
category:
tags: []
---

Is TimeZone.getDSTSavings() in java returns always positive value?


Is TimeZone.getDSTSavings() in java returns always positive value or Negative values also?

I have tried this way

    long millisecondsForGivenDateTime = 0l;
      if (TimeZone.getTimeZone(strTZID).inDaylightTime(
              new Date(millisecondsForGivenDateTime))) {
          millisecondsForGivenDateTime = (millisecondsForGivenDateTime + TimeZone
                  .getTimeZone(strTZID).getDSTSavings());
      }

here strTZID is timezone id dynamically passed to this function and millisecondsForGivenDateTime contains the dynamic value.

I am always getting 3600000 or 0 won't this function return -3600000?


--------------------------------------- 
In theory it _could_ return a negative value - if you were using a `TimeZone` subclass where daylight saving time caused clocks to go back rather than forward.

I very much doubt you'll see that in the wild, although I _have_ seen something similar in the Windows time zone database to get around the fact that Windows couldn't cope with time zones changing their standard UTC offset... if a zone went from UTC+5 to UTC+6 (as standard time) for example - and stopped observing DST - the zone data indicated that "DST" was actually -1 hour, and just inverted when it was in effect from what humans would expect. I've seen this with the Russian time zone, although I believe the data is cleaner now.

The desktop JRE prevents you from constructing a `SimpleTimeZone` with negative DST savings, but I don't know whether the same (undocumented) limitation is present in Android. You could always create your own subclass of `TimeZone` which _did_ return a negative offset though.


