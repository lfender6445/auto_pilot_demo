---
layout: post
title: "How do I print an Instant as rfc2822 in NodaTime?"
description: ""
category:
tags: []
---

How do I print an Instant as rfc2822 in NodaTime?


I'm looking to print an Instant as rfc2822 in NodaTime. How?

Quick search leads to broken google-code links. I'd prefer a built-in named pattern over supplying all formatting to ToString.


--------------------------------------- 
> I'd prefer a built-in named pattern over supplying all formatting to ToString.

If you mean you're expecting a "standard" pattern so to speak, there isn't one.

However, it's easy enough to write a custom pattern for this - giving you an `InstantPattern` instead of passing it all in `ToString`, as you mentioned.

Fortunately, _formatting_ RFC 2822 is considerably simpler than _parsing_ it - especially if you're happy to express everything in UTC. Looking at [RFC 2822](https://www.ietf.org/rfc/rfc2822.txt) itself, two things spring out:

- 

"The date and time-of-day SHOULD express local time." If you want to go along with that, you should be formatting an `OffsetDateTime` instead of an `Instant`.

- 

The day-of-week is optional - but in my experience it's pretty much expected to be there.

Ignoring the "should express local time" part, I'd use:

    var pattern = InstantPattern.CreateWithInvariantCulture
 ("ddd d MMM yyyy HH:mm:ss '+0000'");
    // Test it...
    Console.WriteLine(pattern.Format(SystemClock.Instance.Now));

(Note for future readers: as of Noda Time 2.0, use `IClock.GetCurrentInstant()` instead of `IClock.Now`.)

Sample output:

    Sat 4 Apr 2015 09:55:49 +0000

If you want to go down the `OffsetDateTimePattern` route, you want:

    var pattern = OffsetDateTimePattern.CreateWithInvariantCulture
  ("ddd d MMM yyyy HH:mm:ss o<+HHmm>");

Then you'll get output such as:

    Sat 4 Apr 2015 10:57:27 +0100


