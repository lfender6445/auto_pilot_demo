---
layout: post
title: "Using indexes to get the sum of all the elements in an array list gives unexpected output. What's wrong with my code?"
description: ""
category:
tags: []
---

Using indexes to get the sum of all the elements in an array list gives unexpected output. What's wrong with my code?


I have a folder that contains four files. Each of the four files contains an integer. My code reads the integers from the files into an ArrayList.

    // Reading the save data.
     File[] fileArray = SaveData.listFiles();
     ArrayList<Integer> al = new ArrayList<Integer>();
    
    
     // For each file in the file array
     for (File file2 : fileArray ) {
            FileReader fr = new FileReader(file2);
            al.add (fr.read());
            System.out.println(al); }

The code works. The data from the files are successfully read into an ArrayList. The problem is when I am trying to sum all the elements of the array list.

    int i;
     for(i = 1; i < al.size(); i++) {
     Integer sum = 0;
     sum += al.get(i);
     System.out.println("The sum is: " + sum);

The code shows this output:

    [1]
    [1, 1]
    [1, 1, 3]
    [1, 1, 3, 3]
    The sum is: 1
    The sum is: 3
    The sum is: 3

What's wrong with the code?


--------------------------------------- 
You've declared `sum` _inside_ your loop - so you're starting again on each iteration. You want:

    int sum = 0;
    for(int i = 0; i < al.size(); i++) {
 sum += al.get(i);
    }
    System.out.println("The sum is: " + sum);

Note that:

- I've changed `sum` to be an `int` rather than an `Integer`; there's no need to use `Integer` here [When to use Int vs Integer](http://illegalargumentexception.blogspot.com/2008/08/java-int-versus-integer.html)
- I've changed the lower bound the loop to 0 instead of 1
- You could still use an enhanced loop if you want... (I normally would)
- With Java 8 you could use streams to make it simpler still

