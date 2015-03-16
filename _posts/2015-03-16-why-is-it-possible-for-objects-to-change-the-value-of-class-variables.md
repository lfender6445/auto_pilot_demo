---
layout: post
title: "Why is it possible for objects to change the value of class variables?"
description: ""
category:
tags: []
---

Why is it possible for objects to change the value of class variables?


By Oracle's [definition](http://docs.oracle.com/javase/tutorial/java/javaOO/classvars.html),

> Sometimes, you want to have variables that are common to all objects. This is accomplished with the static modifier. Fields that have the static modifier in their declaration are called static fields or class variables. They are associated with the class, rather than with any object. Every instance of the class shares a class variable, which is in one fixed location in memory.

By this definition, it is safe to deduce that a static variable belongs to the class and shouldn't be accessible for modification by any object of the class.Since all objects share it.

So this line from the same definition is a bit confusing:

> Any object can change the value of a class variable...

So I tried this code and it prints 45 (although I get a warning saying "Static member accessed via instance reference"):

    public class Main {
    
    
    static int value = 8;
    
    
    public static void main(String[] args) {
    // write your code here
    
    
  Main main = new Main();
    
    
  main.value = 45;
    
    
  System.out.println(value);
}
    }

If this was a `Student` class, and I had a static variable called `numberOfStudents`, why should one object of that class be allowed to change the value of this class variable?


--------------------------------------- 
It's not _really_ that "one object" can - it's just you're in code which has access to that variable, and unfortunately Java allows you to access static members (both variables and methods) as if they were instance members. This ends up with very misleading code, e.g.

    Thread t = new Thread(...);
    t.start();
    t.sleep(1000);

The last line _looks_ like it's asking the newly-started thread to sleep - but _actually_ it'll make the current thread sleep.

This is basically a flaw in Java. The compiler will silently turn code like this into

    Thread.sleep(1000);

or in your case

    Main.value = 45;

(I believe that in an older version of Java, it would emit code that checked for nullity with the variable you were accessing the static member "through", but it doesn't even do that any more.)

Many IDEs will allow you to flag code like this with a warning or error. I would encourage you to turn on such a feature. If you see existing code like that, change it to use access the static member directly via the declaring class, so it's clear what's going on.


