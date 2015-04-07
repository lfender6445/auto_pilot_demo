---
layout: post
title: "How many bytes will a string take up?"
description: ""
category:
tags: []
---

How many bytes will a string take up?


Can anyone tell me how many bytes the below string will take up?

    string abc = "a";


--------------------------------------- 
From my [article on strings](http://csharpindepth.com/Articles/General/Strings.aspx):

> In the current implementation at least, strings take up 20+(n/2)\*4 bytes (rounding the value of n/2 down), where n is the number of characters in the string. The string type is unusual in that the size of the object itself varies. The only other classes which do this (as far as I know) are arrays. Essentially, a string is a character array in memory, plus the length of the array and the length of the string (in characters). The length of the array isn't always the same as the length in characters, as strings can be "over-allocated" within mscorlib.dll, to make building them up easier. (StringBuilder does this, for instance.) While strings are immutable to the outside world, code within mscorlib can change the contents, so StringBuilder creates a string with a larger internal character array than the current contents requires, then appends to that string until the character array is no longer big enough to cope, at which point it creates a new string with a larger array. The string length member also contains a flag in its top bit to say whether or not the string contains any non-ASCII characters. This allows for extra optimisation in some cases.

I suspect that was written before I had a chance to work with a 64-bit CLR; I suspect in 64-bit land each string takes up either 4 or 8 more bytes.

EDIT: I wrote up a [blog post](http://codeblog.jonskeet.uk/2011/04/05/of-memory-and-strings) more recently which includes 64-bit information (and contradicts the above slightly for x86...)


