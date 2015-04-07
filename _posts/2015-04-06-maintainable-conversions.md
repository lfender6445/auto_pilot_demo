---
layout: post
title: "Maintainable Conversions"
description: ""
category:
tags: []
---

Maintainable Conversions


I have a class that inherits from a base class; it is almost exactly the same, the difference is a TypeParam to help with intellisense. I want to provide a way to convert an existing parent class to the child class.

I am currently doing it this way:

    class A
    {
 public int f1;
 public int f2;
    }
    
    
    class B<T> : A
    {
 public static B<T> Create(A a)
 {
     return new B<T>
     {
         f1 = a.f1;
         f2 = a.f2;
     };
 }
    }

My concern is that this is not a very maintainable solution, and could cause problems if new fields or properties are added but forgotten in the create method. I also would like to avoid reflection just to copy an object.

Is there a better way to accomplish this?


--------------------------------------- 
The typical way is to provide a copy constructor within each class in the hierarchy. For example:

    class A
    {
  private int f1;
  private int f2;
    
    
  public A()
  {
     ...
  }
    
    
  public A(A original)
  {
      f1 = original.f1;
      f2 = original.f2;
  }
    }
    
    
    class B<T> : A
    {
  public B(A original) : base(original)
  {
  }
    
    
  // Possibly overload with a B(B<T> original) as well?
    }

That way the copying happens in the class which declares the fields. It is best-placed to know how to handle those fields; it definitely has _access_ to the fields even if they're private; when a new field is introduced, you only have to make a change in the same class rather than derived classes.

It's still somewhat ugly, and I'd avoid it if possible - but that depends on the context. (Sometimes using composition instead of inheritance is the way forwards, but that's certainly not universally true.)


