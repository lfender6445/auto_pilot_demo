---
layout: post
title: "How to remove a lambda event handler [duplicate]"
description: ""
category:
tags: []
---

How to remove a lambda event handler [duplicate]


> **Possible Duplicates:**  
> [Unsubscribe anonymous method in C#](http://stackoverflow.com/questions/183367/unsubscribe-anonymous-method-in-c)  
> [How do I Unregister ‘anonymous’ event handler](http://stackoverflow.com/questions/1348150/how-do-i-unregister-anonymous-event-handler)

I recently discovered that I can use lambdas to create simple event handlers. I could for example subscribe to a click event like this:

    button.Click += (s, e) => MessageBox.Show("Woho");

But how would you unsubscribe it?


--------------------------------------- 
The C# specification explicitly states (IIRC) that if you have two anonymous functions (anonymous methods or lambda expressions) it may or may not create equal delegates from that code. (Two delegates are equal if they have equal targets and refer to the same methods.)

To be sure, you'd need to remember the delegate instance you used:

    EventHandler handler = (s, e) => MessageBox.Show("Woho");
    
    
    button.Click += handler;
    ...
    button.Click -= handler;

(I can't find the relevant bit of the spec, but I'd be quite surprised to see the C# compiler aggressively try to create equal delegates. It would certainly be unwise to rely on it.)

If you don't want to do that, you'll need to extract a method:

    public void ShowWoho(object sender, EventArgs e)
    {
   MessageBox.Show("Woho");
    }
    
    
    ...
    
    
    button.Click += ShowWoho;
    ...
    button.Click -= ShowWoho;

If you want to create an event handler which removes itself using a lambda expression, it's slightly trickier - you need to refer to the delegate within the lambda expression itself, and you can't do that with a simple "declare a local variable and assign to it using a lambda expression" because then the variable isn't definitely assigned. You typically get around this by assigning a null value to the variable first:

    EventHandler handler = null;
    handler = (sender, args) =>
    {
  button.Click -= handler; // Unsubscribe
  // Add your one-time-only code here
    }
    button.Click += handler;

Unfortunately it's not even easy to encapsulate this into a method, because events aren't cleanly represented. The closest you could come would be something like:

    button.Click += Delegates.AutoUnsubscribe<EventHandler>((sender, args) =>
    {
  // One-time code here
    }, handler => button.Click -= handler);

Even that would be tricky to implement within `Delegates.AutoUnsubscribe` because you'd have to create a new `EventHandler` (which would be just a generic type argument). Doable, but messy.


