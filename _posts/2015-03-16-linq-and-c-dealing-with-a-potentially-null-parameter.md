---
layout: post
title: "LINQ and C# - Dealing with a potentially null parameter"
description: ""
category:
tags: []
---

LINQ and C# - Dealing with a potentially null parameter


I am relatively new to LINQ but looking for some "best practice" advice on how to deal with the following. I know there are many ways to deal with this, but looking to see how more experienced people would write the code.

My LINQ at present:

    var company = (from c in db.RPTINQUIRies
                    where c.CONCOM == concom && c.LOPER == engineer
                    orderby c.CREATION_DATE descending
                    select c);

Now the `ActionResult` parameter that is being passed in here (engineer) may or may not be empty. Where it is empty, I essentially want to remove the `&& C.LOPER == engineer` clause all together.

What's the best way to deal with this?


--------------------------------------- 
It sounds like you just want:

    where c.CONCOM == concom && (engineer == null || c.LOPER == engineer)

Alternatively, you could build up the query step by step:

    var query = db.RPTINQUIRies.Where(c => c.CONCOM == concom);
    if (engineer != null)
    {
  query = query.Where(c => c.LOPER == engineer);
    }
    query = query.OrderByDescending(c => c.CREATION_DATE);


