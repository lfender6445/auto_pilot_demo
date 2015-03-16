---
layout: post
title: "Cannot get this property name using this code and expression api"
description: ""
category:
tags: []
---

Cannot get this property name using this code and expression api


I have the following class and I need to get its property names:

    public class PMLButtonData
    {
  public int BackgroundColorID
  {
      get;
      set;
  }
    
    
  public string Callback
  {
      get;
      set;
  }
    }

To get the names I'm using this function

    public static string GetPropertyName<T>(Expression<Func<T, object>> lambda)
    {
  MemberExpression member = lambda.Body as MemberExpression;
  PropertyInfo property = member.Member as PropertyInfo;
    
    
  return property.Name;
    }

I can get the Callback property name using this code:

    string name = GetPropertyName<PMLButtonData>(x => x.Callback);

But the same code for the other property doesn't work:

    string name = GetPropertyName<PMLButtonData>(x => x.BackgroundColorID);

The only difference between them is the data type, so I changed the Callback to int and the code does not work with this property anymore. Why can't I get the name of a property this way if it's an integer?


--------------------------------------- 
The problem is the type of your expression tree - you're trying to represent a delegate of type `Func<T, object>`, and if the property returns an `int`, that means it would need to be converted. You just need to make the method generic in both the source _and target_ types:

    public static string GetPropertyName<TSource, TTarget>
  (Expression<Func<TSource, TTarget>> lambda)

Now you should be able to do:

    string name = GetPropertyName<PMLButtonData, int>(x => x.BackgroundColorID);

I realize that's slightly annoying, but you can trampoline via a generic _type_ instead, so you only need to infer a single type parameter:

    public static class PropertyName<TSource>
    {
  public static string Get<TTarget>(Expression<Func<TSource, TTarget>> lambda)
  {           
      // Use casts instead of "as" to get more meaningful exceptions.
      var member = (MemberExpression) lambda.Body;
      var property = (PropertyInfo) member.Member;
     return property.Name;
  }
    }

Then:

    string name = PropertyName<PMLButtonData>.Get(x => x.BackgroundColorID);

Of course, in C# 6 you don't need any of this nonsense:

    string name = nameof(PMLButtonData.BackgroundColorId);

:)


