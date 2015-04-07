---
layout: post
title: "Weird behaviour of compareTo(GregorianCalendar c)"
description: ""
category:
tags: []
---

Weird behaviour of compareTo(GregorianCalendar c)


Could you tell me why the fillowing code:

    int a = new GregorianCalendar(2015,3,31,7,45).compareTo(
      new GregorianCalendar(2015,4,1,7,45);
    System.out.println(a);

prints out 0?

Is there a way to make it work right?

PS: I need to sort strings out by date and I use this comparator:

    array.sort(new Comparator<String>() {
  @Override
  public int compare(String o1, String o2) {
      GregorianCalendar cal1 = new GregorianCalendar(Integer.parseInt(o1.replaceAll(p, "$7")),
              Integer.parseInt(o1.replaceAll(p, "$6")), Integer.parseInt(o1.replaceAll(p, "$5")),
              Integer.parseInt(o1.replaceAll(p, "$8")), Integer.parseInt(o1.replaceAll(p, "$9")));
      GregorianCalendar cal2 = new GregorianCalendar(Integer.parseInt(o2.replaceAll(p, "$7")),
              Integer.parseInt(o2.replaceAll(p, "$6")), Integer.parseInt(o2.replaceAll(p, "$5")),
              Integer.parseInt(o2.replaceAll(p, "$8")), Integer.parseInt(o2.replaceAll(p, "$9")));
      return cal1.compareTo(cal2);
  }
    });

It uses regular expressions, but it is sorted correctly and only the dates provided are not sorted right.


--------------------------------------- 
You're comparing "April 31st" with May 1st. There _is_ no April 31st, so it's rolling over to May 1st anyway. (Okay, it would make more sense to just throw an exception, but hey... that's far from the worst piece of API design in `Calendar`.)

I would strongly recommend using `SimpleDateFormat` to parse string representations of date/time values, instead of doing it yourself. Aside from anything else, `SimpleDateFormat` "knows" that months are 0-based in Java... which is the basic bug you've fallen foul of. The code would also be a lot more readable, I suspect.

Do you really need to keep the collection as a collection of strings anyway? If they're _just_ dates, convert it to a collection of some date type (ideally using Joda Time or Java 8's `java.time` package). If they're something like log entries which have a date but also other information, convert them into a representation of that first. Either way, you've then got a collection which more naturally represents the information it holds.


