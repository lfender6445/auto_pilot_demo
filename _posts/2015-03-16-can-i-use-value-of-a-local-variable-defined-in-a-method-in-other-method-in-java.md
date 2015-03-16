---
layout: post
title: "Can I use value of a local variable defined in a method, in other method in java?"
description: ""
category:
tags: []
---

Can I use value of a local variable defined in a method, in other method in java?


No. The whole point of it being _local_ to a method is that it only exists within that method. The options are:

- Use an instance field, i.e. make it part of the state of the object. That's unlikely to be appropriate.
- Use a static field, i.e. make it part of the static of the type. That's almost _certainly_ inappropriate.
- Change the existing method to return the information you want.
- Create a new method to return the information you want.
- Duplicate the existing code within `remove` so that you can get the index. That would be sad :(

As an example of the last two, you could write:

    public int indexOf(Object input) {       
  int index = 0;    
  while(myAsetIterator.hasNext()) {
      index++;
      if (input.equals(myAsetIterator.next())) {
          return index;
      }
  }
  return -1;
    }
    
    
    public boolean contains(Object input) {
  return indexOf(input) == -1;
    }

... then in your `remove` method, you'd use `indexOf` instead of `contains`.


 **The method is not returning the value of the local variable.**

**Can I use the value of local variable index from the following method**

    public boolean contains(Object input) {
  int index = 0;
    
    
  while(myAsetIterator.hasNext()) {
      index++;
      if(input.equals(myAsetIterator.next())) {
          return true;
      }
  }
  return false;
    }

**in this method as the index of the array of the object that I want to remove.**

    public boolean remove(Object o) {
  int count = 0;
  if(o == null) {
      return false;
  }
  if(contains(o)) {
      genArray[index] == null;
  }
  if (count > 0) {
      System.out.println(count+" same elements were present in Aset. "
              + "Removed all those "+count+" elements from Aset.");
      return true;
  }
  return false;
    }

I know the scope of a local variable is limited to the method it's declared in. But there might be a way that I might not now yet to make this happen without using a field/instance variable. I am not so new at programming but I definitely don't know all the little tricks and tips the gurus have to offer. Worth a shot. Thanks for your time.


