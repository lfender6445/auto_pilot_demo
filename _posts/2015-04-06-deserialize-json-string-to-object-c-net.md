---
layout: post
title: "Deserialize json string to object c#.net"
description: ""
category:
tags: []
---

Deserialize json string to object c#.net


I have a JSON string which needs to be deserialized into an object.

This is what I have tried :

Class :

    public class trn
    {
  public string visited_date { get; set; }
  public string party_code { get; set; }
  public string response { get; set; }
  public string response_type { get; set; }
  public string time_stamp { get; set; }
  public string trans_id { get; set; }
  public double total_amount { get; set; }
  public double discount { get; set; }
    }

json string :

    string json = "{\"trn\":{\"visited_date\":\"2015-04-05\",\"party_code\":\"8978a1bf-c88b-11e4-a815-00ff2dce0943\",\"response\":\"Reason 5\",\"response_type\":\"NoOrder\",\"time_stamp\":\"2015-04-05 18:27:42\",\"trans_id\":\"8e15f00b288a701e60a08f968a42a560\",\"total_amount\":0.0,\"discount\":0.0}}";
    
    
    trn model2 = new System.Web.Script.Serialization.JavaScriptSerializer().Deserialize<trn>(json);

and using json.net

    trn model = JsonConvert.DeserializeObject<trn>(json);

but all the properties are initialized with null values.


--------------------------------------- 
Your JSON represents an object with `trn` as a property within another object. So you need to represent that in your code, as well. For example:

    using System;
    using System.IO;
    using Newtonsoft.Json;
    
    
    public class Transaction
    {
  [JsonProperty("visited_date")]
  public DateTime VisitedDate { get; set; }
  [JsonProperty("party_code")]
  public string PartyCode { get; set; }
  [JsonProperty("response")]
  public string Response { get; set; }
  [JsonProperty("response_type")]    
  public string ResponseType { get; set; }
  [JsonProperty("time_stamp")]
  public DateTime Timestamp { get; set; }
  [JsonProperty("trans_id")]
  public string TransactionId { get; set; }
  [JsonProperty("total_amount")]    
  public double TotalAmount { get; set; }
  [JsonProperty("discount")]
  public double Discount { get; set; }
    }
    
    
    public class TransactionWrapper
    {
  [JsonProperty("trn")]
  public Transaction Transaction { get; set; }
    }
    
    
    class Test
    {
  static void Main(string[] args)
  {
      string json = "{\"trn\":{\"visited_date\":\"2015-04-05\",\"party_code\":\"8978a1bf-c88b-11e4-a815-00ff2dce0943\",\"response\":\"Reason 5\",\"response_type\":\"NoOrder\",\"time_stamp\":\"2015-04-05 18:27:42\",\"trans_id\":\"8e15f00b288a701e60a08f968a42a560\",\"total_amount\":0.0,\"discount\":0.0}}";
      var wrapper = JsonConvert.DeserializeObject<TransactionWrapper>(json);
      Console.WriteLine(wrapper.Transaction.PartyCode);
  }
    }

Note how I've used the `[JsonProperty]` attribute to allow the property names themselves to be idiomatic for .NET, but the JSON property names to still be used appropriately. I've also changed the types of `Transaction` and `VisitedDate`. Finally, it's slightly alarming that `total_amount` and `discount` are `double` values - that's really not suitable for currency values. Unfortunately, you may not be able to control that.


