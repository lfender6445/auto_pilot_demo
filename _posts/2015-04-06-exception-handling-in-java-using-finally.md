---
layout: post
title: "Exception handling in java using finally"
description: ""
category:
tags: []
---

Exception handling in java using finally


    public class CheckProg {
  public int math(int i) {
      try {
          int result = i / 0;
     // throw new IOException("in here");
      } catch (Exception e) {
          return 10;
      } finally {
          return 11;
      }
  }
  public static void main(String[] args) {
      CheckProg c1 = new CheckProg();
      int res = c1.math(10);
      System.out.println("Output :" + res);}

Question:If i run the above code i get the result as Output: 11 Why? Shouldn't the exception be caught before in the catch block and returned ?


--------------------------------------- 
> Shouldn't the exception be caught before in the catch block and returned ?

It _is_ being caught, and that return statement _is_ being executed... but then the return value is being effectively replaced by the return statement in the `finally` block, which will execute whether or not there was an exception.

See [JLS 14.20.2](http://docs.oracle.com/javase/specs/jls/se8/html/jls-14.html#jls-14.20.2) for details of all the possibilities. In your case, this is the path:

> If execution of the try block completes abruptly because of a throw of a value V, then there is a choice:
> 
> - 
> 
> If the run-time type of V is assignment compatible with a catchable exception class of any catch clause of the try statement, then the first (leftmost) such catch clause is selected. The value V is assigned to the parameter of the selected catch clause, and the Block of that catch clause is executed. Then there is a choice:
> 
> - 
> 
> If the catch block completes normally _[... ignored, because it doesn't]_
> 
> - 
> 
> If the catch block completes abruptly for reason R, then the finally block is executed. Then there is a choice:
> 
> - 
> 
> If the finally block completes normally _[... ignored, because it doesn't]_
> 
> - 
> 
> If the finally block completes abruptly for reason S, then the try statement completes abruptly for reason S (and reason R is discarded).

So that bottom line is the important one - the "reason S" (in our case, returning the value 11) ends up being the way that the `try` statement completes abruptly.


