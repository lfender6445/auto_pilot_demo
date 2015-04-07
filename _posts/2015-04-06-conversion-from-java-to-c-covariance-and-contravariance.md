---
layout: post
title: "Conversion from java to c# -Covariance and Contravariance"
description: ""
category:
tags: []
---

Conversion from java to c# -Covariance and Contravariance


    public interface IStorage<T> extends Iterable<T> {
      public void copyTo( IStorage<? super T> dest);
      public void copyFrom( IStorage<? extends T> src);
  }

Above is the java code that I have to put in c#, for the moment it looks like

    interface IStorage<T>: IEnumerable<T>
  {
   void copyTo( IStorage<? super T> dest);
   void copyFrom( IStorage<? extends T> src);}

But I have troubles to find the equivalent of when it appears in the parameter of function, I found the in/out or where approaches but it's still not clear to me.


--------------------------------------- 
Generic variance in C# is _very_ different to generic variance in .NET.

You _sort_ of want something like this:

    public interface IStorage<out T> : IEnumerable<T>
    {
  // This won't compile - the constraint is on the wrong argument
  void CopyTo<TDest>(IStorage<TDest> dest) where T : TDest
    }

But that's invalid, as indicated.

As written, the method doesn't really make sense to me - you'd need something else in the interface which would _accept_ values of type `T`, at which point `IStorage` could no longer be covariant in `T` anyway.

Given that you can't achieve exactly the same effect, I suggest you think about what you really want to achieve, and consider something like:

    public interface IStorage<out T> : IEnumerable<T>
    {
  void AddAll(IStorage<T> source);
    }

Or even just:

    public interface IStorage<out T> : IEnumerable<T>
    {
  void AddAll(IEnumerable<T> source);
    }

So you reverse the target of the call from the source to the destination, at which point the destination can _pull_ values from the source, which is more in-keeping with `IEnumerable<T>` being a source of values.


