---
layout: post
title: "How does the new async/await feature in C# 5 integrate with the message loop?"
description: ""
category:
tags: []
---

How does the new async/await feature in C# 5 integrate with the message loop?


It all comes down to what the "awaiter" does with the continuation it's passed.

The implementation for `Task<T>` in the BCL will use the current synchronization context ( [unless you ask it not to using `ConfigureAwait`](http://msdn.microsoft.com/en-us/magazine/hh456403.aspx)) - which means in WPF/SilverLight it'll use the dispatcher; in Windows Forms it'll use something like `Control.BeginInvoke`, and in a thread-pool thread it'll just keep run on any thread pool thread. Note that it's your current context _at the point of the await expression_ which is important, as that's what the task will capture for the continuation to run on.

The linked blog post (by Mads Torgersen) does a great job of explaining how it all works under the hood, and I have a [series of blog posts](http://codeblog.jonskeet.uk/category/eduasync/) which you may find useful too.


I've not had chance to check out the CTP of the new C# async/await feature, but here's something I was wondering:

How does it integrate with the message loop? I assume that in a standard Windows application (Winforms, WPF) the continuations are called by sending messages to the application's message loop, using a [Dispatcher](http://msdn.microsoft.com/en-us/library/system.windows.threading.dispatcher.aspx) or similar?

What if I'm not using a standard windows message loop? For example in a GTK# application or in a console application (if indeed this feature could be of use at all in a console application).

I've searched the internet for information about this but to no avail. Can anyone explain?


