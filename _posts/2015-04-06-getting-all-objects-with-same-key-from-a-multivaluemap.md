---
layout: post
title: "Getting all objects with same key from a MultiValueMap"
description: ""
category:
tags: []
---

Getting all objects with same key from a MultiValueMap


I have a [`MultiValueMap<Integer, Path>`](https://commons.apache.org/proper/commons-collections/apidocs/org/apache/commons/collections4/map/MultiValueMap.html) from which I am trying to get [_print for the purpose of this question_] out all the paths which were put in the map using the same key.

This is my current solution:

    MultiValueMap<Integer, Path> duplicates = duplicateFinder.getDuplicates();
    
    
    for (Map.Entry<Integer, Object> entry: duplicates.entrySet()) {
final Integer key = entry.getKey();
final Object obj = entry.getValue();
for (Object o: (LinkedList)((ArrayList)entry.getValue()).get(0))
  System.out.println(o);
System.out.println();
    }

I feel my solution is dangerous (casting and magic number 0) and would like to avoid it. How can I achieve the desired result in a more readable/safe manner?


--------------------------------------- 
The entry set seems to be declared with an unfortunate signature. But you could iterate over the keys instead, and call `getCollection` for each:

    for (Integer key : duplicates.keySet()) {
  Collection<Path> paths = duplicates.getCollection(key);
  System.out.println("Paths for " + key);
  for (Path path : paths) {
      System.out.println(" " + path);
  }
  System.out.println();
    }

(Note that Guava's [`Multimap`](http://docs.guava-libraries.googlecode.com/git-history/release/javadoc/com/google/common/collect/Multimap.html) would allow you to use `duplicates.asMap().entrySet()` instead, and each entry would have a `Collection<V>` as a value...)


