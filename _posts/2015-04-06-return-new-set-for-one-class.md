---
layout: post
title: "return new set for one class"
description: ""
category:
tags: []
---

return new set for one class


I ran into a problem with Java recently. I have a HashSet `hashSet` with a superclass 'Foo'. This set is filled with subclasses of `foo` : `bar` and `dop`. How do I return a new HashSet filled with values only with values of class `bar` or `dop`?

I tried the following:

    public Set<Foo> getObjectsFromClass(Foo foo) {
  Set<Foo> objectsFromClass = new HashSet<>();
      for (Foo value: hashSet) {
          if ((value instanceof Bar) && (foo instanceof Bar))
              objectsFromClass.add(value);
          if ((value instanceof Dop) && (foo instanceof Dop))
              objectsFromClass.add(value);
      }
  }
  return objectsFromClass;
    }

But the problem is I have to give up an argument with an object, while I just want to specify the class. How do I solve this?


--------------------------------------- 
It sounds like you want to pass in the class (rather than an instance of the class) and use [`Class.isInstance`](http://docs.oracle.com/javase/8/docs/api/java/lang/Class.html#isInstance-java.lang.Object-):

    public Set<Foo> getObjectsFromClass(Class<? extends Foo> clazz) {
  Set<Foo> objectsFromClass = new HashSet<>();
  for (Foo value: hashSet) {
      if (clazz.isInstance(value)) {
          objectsFromClass.add(value);
      }
  }
  return objectsFromClass;
    }

Then call it with:

    Set<Foo> x = getObjectsFromClass(Dop.class);

As a bonus, the constraint on the parameter means that if you try to do something silly, it won't compile:

    Set<Foo> x = getObjectsFromClass(String.class); // Error

If you need to change the return type to reflect the subtype as well, you can make the method generic:

    static <T extends Foo> Set<T> getObjectsFromClass(Class<T> clazz) {
  Set<T> objectsFromClass = new HashSet<>();
  for (Foo value: hashSet) {
      if (clazz.isInstance(value)) {
          objectsFromClass.add(clazz.cast(value));
      }
  }
  return objectsFromClass;
    }

Then you can use:

    Set<Dop> dops = getObjectsFromClass(Dop.class);


