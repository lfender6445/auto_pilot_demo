---
layout: post
title: "Check system.nullreferenceexception"
description: ""
category:
tags: []
---

Check system.nullreferenceexception


Well, you're calling `FirstOrDefault` - that returns null (or rather, the default value for the element type) if the sequence is empty. So you can detect that with a separate statement:

    @{var sequence = (IEnumerable<Pollidut.ViewModels.ComboItem>)ViewBag.UnionList;
var first = sequence.FirstOrDefault(x => x.ID == item.UNION_NAME_ID); 
var name = first == null ? "Some default name" : first.Name; }
    <text>@UName</text>

In C# 6 it's easier using the null conditional operator, e.g.

    var name = first?.Name ?? "Some default name";

(There's a slight difference here - if `Name` returns null, in the latter code you'd end up with the default name; in the former code you wouldn't.)


My code as follows:

    @{var UName = ((IEnumerable<Pollidut.ViewModels.ComboItem>)ViewBag.UnionList).FirstOrDefault(x => x.ID == item.UNION_NAME_ID).Name;<text>@UName</text>

if ViewBag.UnionList is empty then it troughs system.nullreferenceexception.How to check and validate this?


