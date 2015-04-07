---
layout: post
title: "C# anonymous object with properties from dictionary"
description: ""
category:
tags: []
---

C# anonymous object with properties from dictionary


I'm trying to convert an dictionary to a anonymous object with one property for every Key.

I tried google it but all I could find was how to convert a anonymous object to a dictionary.

My dictionary looks something like this:

    var dict = new Dictionary<string, string>
    {
  {"Id", "1"},
  {"Title", "My title"},
  {"Description", "Blah blah blah"},
    };

And i would like to return a anonymous object that looks like this.

    var o = new 
    {
  Id = "1",
  Title = "My title",
  Description = "Blah blah blah"
    };

So I would like it to loop thru every keyValuePair in the dictionary and create a property in the object for every key.

I don't know where to begin.

Please help.


--------------------------------------- 
You can't, basically. Anonymous types are created by the compiler, so they exist in your assembly with all the property names baked into them. (The property _types_ aren't a problem in this case - as an implementation detail, the compiler creates a generic type and then creates an instance of that using appropriate type arguments.)

You're asking for a type with properties which are determined at _execution_ time - which just doesn't fit with how anonymous types work. You'd have to basically compile code using it at execution time - which would then be a pain as it would be in a different assembly, and anonymous types are internal...

Perhaps you should use [`ExpandoObject`](https://msdn.microsoft.com/en-us/library/system.dynamic.expandoobject) instead? Then anything using `dynamic` will be able to access the properties as normal.


