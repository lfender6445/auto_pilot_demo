---
layout: post
title: "Is it possible to declare a global varaible and initialize it in a function? c#"
description: ""
category:
tags: []
---

Is it possible to declare a global varaible and initialize it in a function? c#


    public Tiles[,] tiles;

Is a global variable, an array, I dare say, the size of which is yet to be discovered. That's why I wish to initialize it inside a function. Alas, after the function is done, so is the variable. How doth one fix that?


--------------------------------------- 
Sounds like you just want:

    private readonly Tile[,] tiles = InitializeTileArray();
    
    
    ...
    
    
    private static readonly Tile[,] InitializeTileArray()
    {
  Tile[,] array = ...;
  // Whatever you want here
  return array;
    }

Note that the method has to be static - you can't call an instance method from a field initializer. If you need to do that, you need to put the call into your constructor instead.

Note that I've made the field itself private - and readonly, which may not be appropriate for you. I would recommend _always_ (or at least nearly always) using private fields - you can expose the data via properties and indexers.


