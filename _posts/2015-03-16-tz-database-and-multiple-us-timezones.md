---
layout: post
title: "TZ database and multiple US timezones"
description: ""
category:
tags: []
---

TZ database and multiple US timezones


I am using pytz to associate time zones with my user profiles. Originally I thought it would just include time zones such as PST, CST, EST, but when I run `pytz.country_timezones('US')` I receive the following list:  
`[u'America/New_York', u'America/Detroit', u'America/Kentucky/Louisville', u'America/Kentucky/Monticello', u'America/Indiana/Indianapolis', u'America/Indiana/Vincennes', u'America/Indiana/Winamac', u'America/Indiana/Marengo', u'America/Indiana/Petersburg', u'America/Indiana/Vevay', u'America/Chicago', u'America/Indiana/Tell_City', u'America/Indiana/Knox', u'America/Menominee', u'America/North_Dakota/Center', u'America/North_Dakota/New_Salem', u'America/North_Dakota/Beulah', u'America/Denver', u'America/Boise', u'America/Phoenix', u'America/Los_Angeles', u'America/Metlakatla', u'America/Anchorage', u'America/Juneau', u'America/Sitka', u'America/Yakutat', u'America/Nome', u'America/Adak', u'Pacific/Honolulu']`

In addition:  
`pytz.all_timezones` == 582`pytz.common_timezones` == 432

I live in Texas and always select Chicago because that's just how the internet works, but now that I have to think into this, I'm really confused as to which time zones we should be using in our application and which are redundant. For example, [America/Kentucky/Louisville](http://en.wikipedia.org/wiki/America/Kentucky/Louisville) is the same as [America/Kentucky/Monticello](http://en.wikipedia.org/wiki/America/Kentucky/Monticello) - why do they both exist? I know that it has to do with Indiana's historical time zone fiasco but why hasn't the database been updated to remove redundancy?

I've never lived in Indiana so I have no idea what time zones residents are accustomed to seeing. Also because of anomalies like Arizona who don't partake in DST, it's not as simple as just including PST, CST, etc.

**Is there some formal subset of TZ database time zones to account for all US residents?**


--------------------------------------- 
> For example, America/Kentucky/Louisville is the same as America/Kentucky/Monticello - why do they both exist?

Because they're _not_ the same. They may observe the same rules from now onwards, but they haven't _always_ done so. Having separate zone IDs for them means that given an instant in time in the past, you can still determine what the local time was at that point.

In the case of Louisville and Monticello, looking at the data it looks like they differed as recently as the 1990s. Here's the data from the 1990s, in terms of which periods the zones observed which names and offsets:

    America/Kentucky/Louisville
    EST: [1989-10-29T06:00:00Z, 1990-04-01T07:00:00Z) -05 (+00)
    EDT: [1990-04-01T07:00:00Z, 1990-10-28T06:00:00Z) -04 (+01)
    EST: [1990-10-28T06:00:00Z, 1991-04-07T07:00:00Z) -05 (+00)
    EDT: [1991-04-07T07:00:00Z, 1991-10-27T06:00:00Z) -04 (+01)
    EST: [1991-10-27T06:00:00Z, 1992-04-05T07:00:00Z) -05 (+00)
    EDT: [1992-04-05T07:00:00Z, 1992-10-25T06:00:00Z) -04 (+01)
    EST: [1992-10-25T06:00:00Z, 1993-04-04T07:00:00Z) -05 (+00)
    EDT: [1993-04-04T07:00:00Z, 1993-10-31T06:00:00Z) -04 (+01)
    EST: [1993-10-31T06:00:00Z, 1994-04-03T07:00:00Z) -05 (+00)
    EDT: [1994-04-03T07:00:00Z, 1994-10-30T06:00:00Z) -04 (+01)
    EST: [1994-10-30T06:00:00Z, 1995-04-02T07:00:00Z) -05 (+00)
    EDT: [1995-04-02T07:00:00Z, 1995-10-29T06:00:00Z) -04 (+01)
    EST: [1995-10-29T06:00:00Z, 1996-04-07T07:00:00Z) -05 (+00)
    EDT: [1996-04-07T07:00:00Z, 1996-10-27T06:00:00Z) -04 (+01)
    EST: [1996-10-27T06:00:00Z, 1997-04-06T07:00:00Z) -05 (+00)
    EDT: [1997-04-06T07:00:00Z, 1997-10-26T06:00:00Z) -04 (+01)
    EST: [1997-10-26T06:00:00Z, 1998-04-05T07:00:00Z) -05 (+00)
    EDT: [1998-04-05T07:00:00Z, 1998-10-25T06:00:00Z) -04 (+01)
    EST: [1998-10-25T06:00:00Z, 1999-04-04T07:00:00Z) -05 (+00)
    EDT: [1999-04-04T07:00:00Z, 1999-10-31T06:00:00Z) -04 (+01)
    EST: [1999-10-31T06:00:00Z, 2000-04-02T07:00:00Z) -05 (+00)
    
    
    America/Kentucky/Monticello
    CST: [1989-10-29T07:00:00Z, 1990-04-01T08:00:00Z) -06 (+00)
    CDT: [1990-04-01T08:00:00Z, 1990-10-28T07:00:00Z) -05 (+01)
    CST: [1990-10-28T07:00:00Z, 1991-04-07T08:00:00Z) -06 (+00)
    CDT: [1991-04-07T08:00:00Z, 1991-10-27T07:00:00Z) -05 (+01)
    CST: [1991-10-27T07:00:00Z, 1992-04-05T08:00:00Z) -06 (+00)
    CDT: [1992-04-05T08:00:00Z, 1992-10-25T07:00:00Z) -05 (+01)
    CST: [1992-10-25T07:00:00Z, 1993-04-04T08:00:00Z) -06 (+00)
    CDT: [1993-04-04T08:00:00Z, 1993-10-31T07:00:00Z) -05 (+01)
    CST: [1993-10-31T07:00:00Z, 1994-04-03T08:00:00Z) -06 (+00)
    CDT: [1994-04-03T08:00:00Z, 1994-10-30T07:00:00Z) -05 (+01)
    CST: [1994-10-30T07:00:00Z, 1995-04-02T08:00:00Z) -06 (+00)
    CDT: [1995-04-02T08:00:00Z, 1995-10-29T07:00:00Z) -05 (+01)
    CST: [1995-10-29T07:00:00Z, 1996-04-07T08:00:00Z) -06 (+00)
    CDT: [1996-04-07T08:00:00Z, 1996-10-27T07:00:00Z) -05 (+01)
    CST: [1996-10-27T07:00:00Z, 1997-04-06T08:00:00Z) -06 (+00)
    CDT: [1997-04-06T08:00:00Z, 1997-10-26T07:00:00Z) -05 (+01)
    CST: [1997-10-26T07:00:00Z, 1998-04-05T08:00:00Z) -06 (+00)
    CDT: [1998-04-05T08:00:00Z, 1998-10-25T07:00:00Z) -05 (+01)
    CST: [1998-10-25T07:00:00Z, 1999-04-04T08:00:00Z) -06 (+00)
    CDT: [1999-04-04T08:00:00Z, 1999-10-31T07:00:00Z) -05 (+01)
    CST: [1999-10-31T07:00:00Z, 2000-04-02T08:00:00Z) -06 (+00)


