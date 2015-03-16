---
layout: post
title: "Enumerable.Zip to enforce same lengths"
description: ""
category:
tags: []
---

Enumerable.Zip to enforce same lengths


I would probably just reimplement `Zip` the way you want to. It's really pretty simple - the following is trivially adapted from MoreLINQ. You'll want to give it a better name, mind you...

    public static IEnumerable<TResult> ZipForceEqual<TFirst, TSecond, TResult>(
  this IEnumerable<TFirst> first,
  IEnumerable<TSecond> second,
  Func<TFirst, TSecond, TResult> resultSelector)
    {
  if (first == null) throw new ArgumentNullException("first");
  if (second == null) throw new ArgumentNullException("second");
  if (resultSelector == null) throw new ArgumentNullException("resultSelector");
    
    
  return ZipForceEqualImpl(first, second, resultSelector);
    }
    
    
    static IEnumerable<TResult> ZipForceEqualImpl<TFirst, TSecond, TResult>(
  IEnumerable<TFirst> first,
  IEnumerable<TSecond> second,
  Func<TFirst, TSecond, TResult> resultSelector)
    {
  using (var e1 = first.GetEnumerator())
  using (var e2 = second.GetEnumerator())
  {
      while (e1.MoveNext())
      {
          if (e2.MoveNext())
          {
              yield return resultSelector(e1.Current, e2.Current);
          }
          else
          {
              throw new InvalidOperationException("Sequences differed in length");
          }
      }
      if (e2.MoveNext())
      {
          throw new InvalidOperationException("Sequences differed in length");
      }
  }
    }


I found myself frequently need to use `Enumerable.Zip()`, but having it to ensure the two `IEnumerable`s to have the same length (or both to be infinite). E.g., if one enumerable reaches the end but the other doesn't, I want it to throw. According to the [doc](https://msdn.microsoft.com/en-us/library/vstudio/dd267698%28v=vs.100%29.aspx), Zip() will just stop enumerating as soon as one of them comes to the end.

I ended up always need something like below. What's the most "built-in"/elegant way to address this?

    void Foo(IEnumerable<int> a, IEnumerable<int> b)
    {
  // caching them. they are not huge or infinite in my scenario
  var a = a.ToList();
  var b = b.ToList();
    
    
  if (a.Count() != b.Count())
  {
      throw ...;
  }
    
    
  Enumerable.Zip(a, b, ...);
    }


