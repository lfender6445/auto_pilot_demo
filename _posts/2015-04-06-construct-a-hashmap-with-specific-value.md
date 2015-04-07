---
layout: post
title: "Construct a HashMap with specific value"
description: ""
category:
tags: []
---

Construct a HashMap with specific value


I have a List of Module as below, and I try to construct a HashMap without a duplicate key, and the value is latest.

    DateTime start = new DateTime(2010, 5, 1, 12, 0, 0, 0);
    List<Module> modules = Arrays.asList(
 new Module("s", start.plusDays(4)),
 new Module("l", start.plusDays(3)),
 new Module("s", start.plusDays(2)),
 new Module("s", start.plusDays(9)),
 new Module("s", start.plusDays(1))
    );

Module:

    public class Module {
 private String name;
 private DateTime date;
    
    
 public Module(String name, DateTime date) {
    this.name = name;
    this.date = date;
 }
 //getter methods;

I want to construct a HashMap. Its Key is the name of the Module, and its Value is the latest date of the Module, so the output should be `{l=2010-5-4,s=2010-5-10}`, so is there any efficient way to do this?


--------------------------------------- 
The _simplest_ way would just be to order by date (e.g. using a `Comparator<Module>`) and then just iterate:

    Map<String, DateTime> map = new HashMap<>();
    for (Module module : sortedList) {
  map.put(module.getName(), module.getDate());
    }

That will overwrite earlier values with later ones, because they will come later in the list.

There may be somewhat more efficient ways of doing this, but they're unlikely to be as simple - I would use the simple approach first and see whether it's efficient enough.

You could also use Java 8 streams to do this, but `Collectors.toMap` will throw an exception if it encounters duplicate keys, making it slightly trickier. You could group by the name instead and then just take the latest element of each, but again that's likely to end up being more complicated than the simple approach above.


