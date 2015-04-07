---
layout: post
title: "How to check if bool is false in a loop"
description: ""
category:
tags: []
---

How to check if bool is false in a loop


I'm trying to loop through an array of classes. The class has two variables: a transform and a bool.

I want to loop through this in another script to see if that current position is occupied and if so the bool occupied will be set to true.

How can I go about doing this?

    public Positions[] PosInObect = new Positions[1];
    
    
     [System.Serializable]
     public class Positions
     {
   public Transform pos;
   public bool isFilled;
     }
    
    
     for (int i = 0; i < TheObject.GetComponent<GetInObject>().PosInObect.Length; i++) 
     {
    
    
     }


--------------------------------------- 
Well, you can just access the element at the relevant index, and then check the field value:

    if (TheObject.GetComponent<GetInObject>().PosInObect[i].isFilled)

However, if you don't need the index, I'd recommend using a `foreach` loop:

    foreach (var position in TheObject.GetComponent<GetInObject>().PosInObect)
    {
  if (position.isFilled)
  {
      ...
  }
    }

And if you _do_ need the position, I'd use a local variable to fetch the array once first:

    var positions = TheObject.GetComponent<GetInObject>().PosInObect;
    for (int i = 0; i < positions.Length; i++)
    {
  if (positions[i].isFilled)
  {
      ...
  }
    }

I'd also recommend using properties instead of public fields, and following .NET naming conventions.


