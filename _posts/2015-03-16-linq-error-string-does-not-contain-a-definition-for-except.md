---
layout: post
title: "Linq error: “string[] does not contain a definition for 'Except'.”"
description: ""
category:
tags: []
---

Linq error: “string[] does not contain a definition for 'Except'.”


Here's my code:

    public static string[] SplitKeepSeparators(this string source, char[] keptSeparators, char[] disposableSeparators = null)
  {
      if (disposableSeparators == null)
      {
          disposableSeparators = new char[] { };
      }
    
    
      string separatorsString = string.Join("", keptSeparators.Concat(disposableSeparators));
      string[] substrings = Regex.Split(source, @"(?<=[" + separatorsString + "])");
    
    
      return substrings.Except(disposableSeparators); // error here
  }

I get the compile time error `string[] does not contain a definition for 'Except' and the best extension method overload ... has some invalid arguments`.

I have included `using System.Linq` in the top of the source file.

What is wrong?


--------------------------------------- 
Your `substrings` variable is a `string[]`, but `disposableSeparators` is a `char[]` - and [`Except`](https://msdn.microsoft.com/en-us/library/vstudio/bb300779%28v=vs.100%29.aspx) works on two sequences of the same type.

Either change `disposableSeparators` to a `string[]`, or use something like:

    return substrings.Except(disposableSeparators.Select(x => x.ToString())
               .ToArray();

Note the call to `ToArray()` - `Except` just returns an `IEnumerable<T>`, whereas your method is declared to return a `string[]`.


