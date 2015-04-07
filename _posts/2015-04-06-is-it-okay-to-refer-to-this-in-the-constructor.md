---
layout: post
title: "Is it okay to refer to “this” in the constructor?"
description: ""
category:
tags: []
---

Is it okay to refer to “this” in the constructor?


In C#, a common pattern that I use is to populate the details of a lower calculation class with a form object.

The constructor for MyForm is:

    MyForm()
    {
 _MyFormCalcs = new MyFormCalcs(this);
    }

But I encountered an error today which makes me think that as my constructor had not finished completing, it creates a new instance of MyForm to pass into MyData. Thus it calls the constructor twice. I found that a static list in MyFormCalcs was being filled twice and was failing the second time as the keys were already present in the list.

Can I use this in the constructor to refer to this instance? What will it contain in the lower class - has the constructor been run or not.

What is a better way of passing my form into the lower class?


--------------------------------------- 
No, that won't create a new instance of `MyForm`.

In general, allowing `this` to "escape" from a constructor is [dangerous](http://codeblog.jonskeet.uk/2010/09/02/don-t-let-this-get-away/) as it means it can be used before the constructor has completed, but it's not going to be creating a new instance. If you could give a short but complete example of the problem you've seen, we could help diagnose it further. In particular, it's not clear what you mean about the "static list being filled twice". Usually it's not a good idea to populate a _static_ variable in an _instance_ constructor.


