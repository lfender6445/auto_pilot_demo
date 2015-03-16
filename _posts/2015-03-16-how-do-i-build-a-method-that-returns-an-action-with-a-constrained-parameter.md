---
layout: post
title: "How do I build a method that returns an action with a constrained parameter?"
description: ""
category:
tags: []
---

How do I build a method that returns an action with a constrained parameter?


I have a common encapsulation I've been using in my controllers to handle alert message passing, exceptions, and error logging. Here is a simple version of it:

    private void ActionHelper(Action<SpecificDbContext> DatabaseActions)
    {
  try {
      DatabaseActions(db);
  }
  catch (Exception ex) {
      // error handling
  }
    }

This makes it so I can simply define the database interaction in an anonymous function and pass it, and it handles all the other stuff. I do have to create this ActionHelper on each controller though, since they each use a different DbContext - I'd like to generalize it.

What I would like is a method where I can pass the type (that implements DbContext) and have it return the above method. I imagine the signature would look something like this:

    public Action<T where T : DbContext> Builder(Type type)

and I would use it something like this:

    Action<SpecificDbContext> ActionHelper = Builder(typeof(SpecificDbContext));

How should I build this method that returns actions?


--------------------------------------- 
I suspect you just want:

    public Action<T> Builder<T>() where T : DbContext

Then you could call it as:

    Action<SpecificDbContext> actionHelper = Builder<SpecificDbContext>();

You don't need the `type` argument, as within the method you can use `typeof(T)`. But:

- You do need to make it a generic method, which means putting the type parameter after the method name
- Unlike Java, where the constraint is specified at the same place as the type parameter, in C# the constraints go at the end of the class or method declaration

