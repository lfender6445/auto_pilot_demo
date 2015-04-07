---
layout: post
title: "Is there a better way of filling a generic List from a SQL DataAdapter?"
description: ""
category:
tags: []
---

Is there a better way of filling a generic List from a SQL DataAdapter?


I have an existing application that uses Active Record for its data retrieval. It's in VB.NET (first time I'm doing VB.NET; I usually work in C#). And I'm building a method to return a `List(Of T)` of an object.

The current pattern uses a `SQLDataAdapter` to populate a datatable. I COULD add the record to the `List(Of T)` as I fill the datatable, but there HAS to be a better way to do this.

Any ideas? I'm not married to using `SQLDataAdapter`, if there's a better way that avoids it...


--------------------------------------- 
As you've still not had any responses...

I haven't used Active Record myself, so I don't know at what point that makes any kind of difference but it strikes me that reading into a `DataTable` _and_ a `List<T>` is duplicating things somewhat.

How about populating the `List<T>` from a `SqlDataReader` instead? As you move through the results using `Read()`, create a new object from the current row and add it to the list. If you need to do it for various different types, I'd write a generic method to do it, along the lines of:

    public static List<T> ToList<T>(this SqlDataReader reader,
  Func<SqlDataReader, T> rowConverter)
    {
  List<T> ret = new List<T>();
  while (reader.Read())
  {
      ret.Add(rowConverter(reader));
  }
  return ret;
    }

Then you can implement the converter with a lambda expression or anonymous method.

Alternatively you could make the extension method target the command instead of the `SqlDataReader` - it could deal with calling `ExecuteReader`, converting every row and then disposing of the reader afterwards.

(It's a slightly odd signature because `SqlDataReader` represents both the iterator _and_ the current row; just a quirk of the API.)

I'm probably missing something deeper though - if this doesn't help, could you explain why, perhaps as a question edit?


