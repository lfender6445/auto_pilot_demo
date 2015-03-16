---
layout: post
title: ".StartsWith and .Contains are returning null when comparing dates"
description: ""
category:
tags: []
---

.StartsWith and .Contains are returning null when comparing dates


Without trying to work out exactly this fails, I would _strongly_ recommend not using string representations for this sort of thing anyway. Just use `DateTime` comparisons instead - assuming that `DateApproved` is a `DateTime` column, of course. (If it's not, make it so!)

    var thisDate = DateTime.Now;
    var start = new DateTime(thisDate.Year, thisDate.Month, 1);
    var end = start.AddMonths(1);
    var specifiedTotal = (from t in db.Transaction
                    where t.AgentId == CurrentUser.SalesAgent.AgentId
                    && t.Status.Status == "Approved"
                    && t.DateApproved >= start && t.DateApproved < end
                    select (decimal?)t.AmountApproved).Sum() ?? 0;

In general, you should avoid using string operations unless you're _actually_ interested in text. In this case, you're not - you're trying to perform a range comparison on dates. That has nothing to do with textual representations of them.


In my application, I was trying to pull out the sum of values in a specific column for a specific period of time. For example if I want it to pull the sum for every month I did something like this

    var thisDate = DateTime.Now;
    var currentDay = thisDate.Day;
    var thisMonth = DateTime.Now.ToString("MM");
    var thisYear = thisDate.Year.ToString();
    var thisYearthisMonth = string.Format("{0}-{1}", thisYear, thisMonth);
    var SpecifiedTotal = (from t in db.Transaction
                    where t.AgentId == CurrentUser.SalesAgent.AgentId
                    && t.Status.Status == "Approved"
                    && t.DateApproved.ToString().StartsWith(thisYearthisMonth)
                    select (decimal?)t.AmountApproved).Sum() ?? 0;

Setting a breakpoint showed me that SpecifiedTotal was evaluating to zero. I tried to find out why by removing the line `&& t.DateApproved.ToString().Contains(thisYearthisMonth)` and it evaluated to the right value. In essence i tried to pull out the sum of the values in a column for the period of March i.e 2015-03 so i thought comparing the stored date with that by finding any date that starts with 2015-03 would make sense. What could i have done wrong?


