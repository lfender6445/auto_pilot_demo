---
layout: post
title: "how to access variables from private bodies in java"
description: ""
category:
tags: []
---

how to access variables from private bodies in java


    public void TheBank() {
    Scanner Sc = new Scanner(System.in);
  System.out.println("Please Enter your Username and Password");
  MemoryStorage();// Stores the Username and Password in the system.
  VariableCompare();// Compares the Username and Password to see if they match or do not
    }
    
    
    private void MemoryStorage(){// this should just be here to store the variables username and password
  Scanner Sc = new Scanner(System.in);
  String username = Sc.nextLine();
  String password = Sc.nextLine();
    }
    private void VariableCompare() {// this should compare to see if they match or dont and print the results
  if (username.equals (password){
      System.out.println("Please try again your Username and Password cannot be the same");
  } else {
      System.out.println (" Your username is:" + username);
      System.out.println(" Your password is:" + password);
  }
    }
    }

My question is the body (MemoryStorage), i want it to save the username and password, so that the other bodies can use it aswell to proceed with their calculations. At the moment the variables username and password are not accepted into the other bodies and i want to know how i can make those two variables available to all bodies to use.


--------------------------------------- 
Currently you're declaring _local_ variables. Those only exist while you're executing the method. It sounds like they should actually be _instance_ variables (fields) within your class:

    public class Whatever {
  private String username;
  private String password;
    
    
  // Methods which assign to username/password and read from them
    }

You should also read up on naming conventions in Java, and think about how to name your methods more along the lines of what they're actually doing. Oh, and consider passing the `Scanner` into your current `MemoryStorage` method rather than creating a new one - I've seen various problems when people create multiple instances of `Scanner` with the same underlying stream.

As an alternative to instance fields, you could consider using return values from the methods. For example:

    AuthenticationInfo auth = requestUserAuthentication(scanner);
    validateAuthentication(auth);

... again though, it's not clear that these should really be separate methods. Why is the method which _asks_ for the auth info not validating it? Note that the validation you're using is a simple one which isn't actually checking that the username/password combination is _correct_ - it's just checking that it's _possibly_ correct (the same sort of validation as would check for a minimal password length etc).


