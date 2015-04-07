---
layout: post
title: "Implementing an attribute with similar behavior to CompilerServices.CallerMemberAttribute"
description: ""
category:
tags: []
---

Implementing an attribute with similar behavior to CompilerServices.CallerMemberAttribute


It is possible to create an attribute that has a behavior similar to `CallerMemberNameAttribute`?

I mean, I have googled and found [this article](http://www.journeyintocode.com/2013/04/callermembername-net-40.html), that says CallerMemberName is a attribute that belongs to CompilerServices group, or in other words, this attributes change the way that compiler will builds my IL. So it's impossible replicate this behavior without customizing the c# compiler.

But I'm not convinced yet. I have some hope that someone in stackoverflow can say otherwise. So this question is for it.

**Some context:**

I'm searching for this mostly for improve this code:

    public int Prop
    {
  { get { return (int)this["prop"]; }
  { set { this["prop"] = value; }
    }

I have many classes in my application that is a dictionary and has a property that represents a specific key.

Using `StackTrace` (in C# 4.0) and `CallerMemberName` (in C# 5.0) I was able to update my code to this:

    public int Prop
    {
  { get { return Get(); }
  { set { Set(value); }
    }

Now my goal is to archive some like this:

    public int Prop { { [DicGet]get; [DicSet]set; } }

So can someone help me? It's possible?


--------------------------------------- 
> It is possible to create an attribute that has a behavior similar to CallerMemberNameAttribute?

Only by changing the C# compiler yourself, basically. After all, you're asking for behaviour similar to something that the C# compiler has specific knowledge of and code to handle - so you should expect that the C# compiler would need specific knowledge and code to handle your similar situation.

> Now my goal is to archive some like this:
> 
> public int Prop { { [DicGet]get; [DicSet]set; } }
> 
> So can someone help me? It's possible?

Not out of the box, no.

Options:

- Modify the Roslyn compiler (it's [open source](https://github.com/dotnet/roslyn) now) - I wouldn't recommend that though.
- Use [PostSharp](https://www.postsharp.net/)
- Use some sort of preprocessor before you compile
- Use dynamic typing instead (e.g. extend `DynamicObject` and handle property accesses that way)

