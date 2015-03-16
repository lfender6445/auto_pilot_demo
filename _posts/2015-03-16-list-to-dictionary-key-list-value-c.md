---
layout: post
title: "List to Dictionary<Key, List<Value>> - C#"
description: ""
category:
tags: []
---

List to Dictionary<Key, List<Value>> - C#


Well, when you group you can specify the value you want for each element of the group:

    var dictionary = list.GroupBy(p => p.TypeID, p => p.NoticeID)
                   .ToDictionary(p => p.Key, p => p.ToList());

However, I would strongly consider using a lookup instead of a dictionary:

    var lookup = list.ToLookup(p => p.TypeID, p => p.NoticeID);

Lookups are much cleaner in general:

- They're immutable, whereas your approach ends up with lists which can be modified
- They express in the type system exactly what you're trying to express (one key to multiple values)
- They make looking keys up easier by returning an empty sequence of values for missing keys, rather than throwing an exception

I have a List and MyClass is:

    public class MyClass
    {
  public bool Selected { get; set; }
  public Guid NoticeID { get; set; }
  public Guid TypeID { get; set; }
    }

My question is, how do i convert this list into a `Dictionary<Guid, List<Guid>>`, where the dictionary key is the GUID from the `TypeID` property, and the value is a list of all the `NoticeID` values corresponding to that `TypeID`. I have tried like so:

    list.GroupBy(p => p.TypeID).ToDictionary(p => p.Key, p => p.ToList())

but this returns a `Dictionary <Guid, List<MyClass>>`, and I want a `Dictionary<Guid, List<Guid>>`.


