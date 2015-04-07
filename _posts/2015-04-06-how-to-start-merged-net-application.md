---
layout: post
title: "How to start merged .NET application?"
description: ""
category:
tags: []
---

How to start merged .NET application?


So, I use ILMerge to merge my .NET assemblies to one. Basically, the one .NET application is the core, the console and the other .NET application is a GUI, the front-end. Now, the GUI calls up the console-application and passes the arguments to it. Done. But now I merged my console-application into my GUI application. How would I now call my console-application, which is now merged with the GUI, in my GUI application code?


--------------------------------------- 
You would just call the `Main` method of the console code:

    public class GuiApp
    {
  public void WhenYouWantToCallTheConsole()
  {
      // Probably in a different thread...
      ConsoleApp.Main(...);
  }
    }
    
    
    public class ConsoleApp
    {
  public static void Main(string[] args)
  {
      ...
  }
    }

Of course, this will run the console app _in the same process_ - whereas previously presumably you started it as a separate process. In many cases this is fine, but you need to be aware of it as a difference.


