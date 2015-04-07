---
layout: post
title: "Unexpected behavior for a collection of an instance"
description: ""
category:
tags: []
---

Unexpected behavior for a collection of an instance


For example i have the following class:

    class Person
    {
  public List<int> Grades{ get; set; }
    
    
  public Person(List<int> grades)
  {
      this.Grades = grades;
  }
    }

And than i use this class in a main method , something like:

    static void Main(string[] args)
  {
      List<int> grades = new List<int> { 1, 2, 3, 4, 5 };
      Person person = new Person(grades);
    
    
      for (int i = 0; i < 5; i++)
      {
          if (i % 2 == 0)
          {
              grades[i] = 0;
          }
          else
          {
              grades[i] = -1;
          }
      }
    
    
      foreach(var grade in person.Grades)
      {
          Console.Write(grade + " ");
      }
    
    
      Console.ReadKey();
  }

After running this code i expected to have on console the: 1 2 3 4 5 output result. Insteead i have this output result: 0 -1 0 -1 0

I expected that the collection "saved" into Person instance to stay how it was initialized. What should i do to keep this collection unmodified for Person instances, so that i will have the "1 2 3 4 5" output result even if i modify the grades collection in main method.

Can someone please explain me, why is this happening ?


--------------------------------------- 
> I expected that the collection "saved" into Person instance to stay how it was initialized.

It's time to revisit your expectations of how reference types work in C# then :) I have an [article](http://pobox.com/~skeet/csharp/references.html) that you might find useful...

> What should i do to keep this collection unmodified for Person instances, so that i will have the "1 2 3 4 5" output result even if i modify the grades collection in main method.

You can copy the collection in the constructor:

    public Person(List<int> grades)
    {
  this.Grades = new List<int>(grades);
    }

Now for a `List<int>` that's fine - if you have a list of a mutable type, however, you potentially want to clone each _element_ too. This sort of thing is why immutable types are nice - it's much easier to reason about their behaviour, because nothing can mess with instances, so you can just keep references...


