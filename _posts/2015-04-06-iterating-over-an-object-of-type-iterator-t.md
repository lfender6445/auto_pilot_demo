---
layout: post
title: "Iterating over an object of type Iterator<T>"
description: ""
category:
tags: []
---

Iterating over an object of type Iterator<T>


While reading through the Wikipedia article on [`Generators`](http://en.wikipedia.org/wiki/Generator_%28computer_programming%29#Java), I found the following Java implementation to iterate over a generic type `Iterator<Integer>` produce an infinite sequence of Fibonacci numbers

    Iterator<Integer> fibo = new Iterator<Integer>() {
  int a = 1;
  int b = 1;
  int total;
    
    
  @Override
  public boolean hasNext() {
      return true;
  }
    
    
  @Override
  public Integer next() {
      total = a + b;
      a = b;
      b = total;
      return total;
  }
    
    
  @Override
  public void remove() {
      throw new UnsupportedOperationException();
  }
    }
    // this could then be used as...
    for(int f: fibo) {
  System.out.println("next Fibonacci number is " + f);
  if (someCondition(f)) break;
    }

However, the above code does't work when put inside `main` method of a class. It says

    Can only iterate over an array or an instance of java.lang.Iterable

which is understandable. Does it mean the above example is wrong or incomplete? Am I missing something?


--------------------------------------- 
The code sample on Wikipedia is invalid, but you can easily iterate anyway, just by calling `hasNext()` and `next()` explicitly.

    // We know that fibo.hasNext() will always return true, but
    // in general you don't...
    while (fibo.hasNext()) {
  int f = fibo.next();
  System.out.println("next Fibonacci number is " + f);
  if (someCondition(f)) break;
    }


