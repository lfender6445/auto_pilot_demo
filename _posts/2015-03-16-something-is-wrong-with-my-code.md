---
layout: post
title: "Something is wrong with my code"
description: ""
category:
tags: []
---

Something is wrong with my code


Well yes, look at this code (reformatted from your question for readability):

    object key(int count, accidental ac)
    { 
  return key(0, accidental.none);
    }

That will just invoke the same method... which will invoke the same method... which will invoke the same method etc, until it runs out of stack space.

It's not clear what you _intended_ to return from this method, but you need to stop recursing in this infinite way.


I am making a music maker program in C# (visual studio).  
Here is my code:

    int accCount = 0;
    enum accidental { flat, sharp, none }
    accidental thisAcc = accidental.none;
    if (keyComboBox.SelectedItem.ToString().Length < 8)
    {
 MessageBox.Show("Please select a key!");
    }
    else switch (keyComboBox.SelectedItem.ToString())
    {
  case "C major - A minor":
      accCount = 0; thisAcc = accidental.none;
      break;
  case "G major - E minor":
      accCount = 1; thisAcc = accidental.sharp;
      break;
  ...etc..
    }

and so on...  
This all is included in `postButton_click(postButton_Click(object sender, EventArgs e)`  
But when I click the button, an exception is shown   
(An unhandled exception of type 'System.StackOverflowException' occurred in Program.exe)  
  
  
And if I select "break", this line is selected:

    object key(int count, accidental ac) (here is the cursor){ 
  return key(0, accidental.none); 
    }

Does anyone know what is wrong?  
Sorry if this question is not specific enough, just tell me.


