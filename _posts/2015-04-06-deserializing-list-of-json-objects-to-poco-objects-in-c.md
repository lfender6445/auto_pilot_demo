---
layout: post
title: "Deserializing list of json objects to POCO objects in C#"
description: ""
category:
tags: []
---

Deserializing list of json objects to POCO objects in C#


I am making a call to a servie that returns a list of jso serialized objects such as this:

{"employees":[{"employee":{"id":"1","date\_created":"2011-06-16T15:03:27Z","extended":[{"address":{"street1":"12345 first st.","city":"Denver","state":"CO"}}]}},{"employee":{"id":"2"...

So, you can see I first-off have a list of employee objects called employees. On top of that, each employee object contains another object called extended for extended info (in this case address info). What I would like to acheive is passing in the entire list as a string to a deserializer and getting back a List with the Employee object looking like this:

    [Serializable]
    public class Employee {
  public string Id { get; set; }
  public string DateCreated { get; set; }
  public ExtendedProperties Address { get; set; }
    }
    
    
    [Serializable]
    public class ExtendedProperties
    {
  public string Street1 { get; set; }
  public string City { get; set; }
  public string State { get; set; }
    }

I have found similar examples using NEwtonSoft but they are not quite the same in terms of the composite object. If needed I can drop the extended properties. But that would be far from ideal.

Any help would be greatly appreciated.

TIA!


--------------------------------------- 
Well, there are a few things here:

- You've got an outer "wrapper" level or two, mapping the `employees` property to the actual collection of properties. You can either deal with that with a separate class, or read the whole thing using LINQ to JSON and then dig in one layer before deserializing the collection.
- It looks like you've actually got a _collection_ of extended properties per employee, with one property of extended properties being the address.
- I'm not sure how to persuade the JSON library to convert `date_created` to `DateCreated`, although I dare say it could.

I've hacked up something to read this - but it's a bit ugly:

    using System;
    using System.Collections.Generic;
    using System.IO;
    
    
    using Newtonsoft.Json;
    
    
    public class EmployeeCollection {
  public List<EmployeeWrapper> Employees { get; set; }
    }
    
    
    public class EmployeeWrapper {
  public Employee Employee { get; set; }
    }
    
    
    public class Employee {
  public string Id { get; set; }
  public string Date_Created { get; set; }
  public List<ExtendedProperty> Extended { get; set; }
    }
    
    
    public class ExtendedProperty {
  public Address Address { get; set; }
    }
    
    
    public class Address
    {
  public string Street1 { get; set; }
  public string City { get; set; }
  public string State { get; set; }
    }
    
    
    class Test
    { 
  static void Main() 
  {
      string json = @"{""employees"":
          [{""employee"":
              {""id"":""1"",
               ""date_created"":""2011-06-16T15:03:27Z"",
               ""extended"":[
                  {""address"":
                  {""street1"":""12345 first st."",
                   ""city"":""Denver"",
                   ""state"":""CO""}}]
            }}]}";
    
    
    
    
      var employees =
           JsonConvert.DeserializeObject<EmployeeCollection>(json);
      foreach (var employeeWrapper in employees.Employees)
      {
          Employee employee = employeeWrapper.Employee;
          Console.WriteLine("ID: {0}", employee.Id);
          Console.WriteLine("Date created: {0}", employee.Date_Created);
          foreach (var prop in employee.Extended)
          {
              Console.WriteLine("Extended property:");
              Address addr = prop.Address;
              Console.WriteLine("{0} / {1} / {2}", addr.Street1,
                                addr.City, addr.State);
          }
      }
  }     
    }

If you want to keep your _original_ class structure, I suggest you use LINQ to JSON to do a more manual conversion. It's not terribly hard, when you get used to the JSON library - particularly if you're happy with LINQ to Objects.


