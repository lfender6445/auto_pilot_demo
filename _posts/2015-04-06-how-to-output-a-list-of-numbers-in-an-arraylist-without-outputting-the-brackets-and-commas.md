---
layout: post
title: "How to output a list of numbers in an Arraylist without outputting the Brackets and Commas?"
description: ""
category:
tags: []
---

How to output a list of numbers in an Arraylist without outputting the Brackets and Commas?


I have the following code used to help me find the prime numbers between 1 and whatever the user inputs. The only problem is, I have to output the numbers without the Brackets and Commas. How do I do that?

    System.out.println("\nLab1la\n");
  Scanner input = new Scanner(System.in);
  System.out.println("Enter the primes upperbond ==>> ");
  final int MAX = input.nextInt();
  boolean primes[];
  primes = new boolean[MAX];
    
    
  ArrayList<Integer>PrimeFactor = new ArrayList<Integer>();
  for (int i = 2; i < MAX + 1 ; i++)
  {
      PrimeFactor.add(i); 
  }
    
    
    
    
  CompositeNumbers(PrimeFactor);
  System.out.println("COMPUTING RIME NUMBERS");
  System.out.println();
  System.out.println("PRIMES BETWEEN 1 AND " + MAX);
  System.out.print(PrimeFactor);
    
    
    }
    
    
    public static void CompositeNumbers(ArrayList<Integer> PrimeFactor)
    {
  for (int i = 0; i < PrimeFactor.size(); i++)
  {
      if (!isPrime(PrimeFactor.get(i)))
      { 
          PrimeFactor.remove(i);
          i--;
    
    
      }
  }
    }
    
    
    public static boolean isPrime(int n)
    {
  if(n==1)
  {
      return true;
  }
  for (int i = 2; i < n +1/2; i++)
  {
      if (n%i == 0)
      {
          return false;
    
    
      }
  }
  return true;
    
    
    }

}


--------------------------------------- 
Just output each value in turn. For example:

    // TODO: Rename PrimeFactor to primeFactors to follow Java naming conventions
    for (int value : PrimeFactor)
    {
  System.out.print(value);
  System.out.print(" "); // Or whatever separator you want
    }

(This will output an extra space at the end; getting rid of that is _slightly_ fiddly, but not too hard...)

Or use something like Guava's [`Joiner`](http://docs.guava-libraries.googlecode.com/git-history/release/javadoc/com/google/common/base/Joiner.html) class:

    System.out.println(Joiner.on(' ').join(PrimeFactor));


