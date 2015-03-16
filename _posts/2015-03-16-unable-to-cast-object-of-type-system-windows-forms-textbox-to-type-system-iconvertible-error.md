---
layout: post
title: "Unable to cast object of type 'system.windows.forms.textbox' to type 'System.IConvertible' error"
description: ""
category:
tags: []
---

Unable to cast object of type 'system.windows.forms.textbox' to type 'System.IConvertible' error


You're currently trying to convert the textboxes themselves to integers. That's not going to work. You need to convert the _text within the textboxes_:

    iDay1 = Convert.ToInt32(txtBox1.Text);

(etc).

You should **absolutely definitely** stop building your SQL like that though. Read up about parameterized SQL, to avoid SQL injection attacks, to make your code easier to read, and to avoid conversion issues.

You should also consider:

- Using an array or other collection for all these textboxes, so you could just loop.
- Removing the `i` prefixes - [.NET naming conventions](https://msdn.microsoft.com/en-us/library/ms229045) specifically reject Hungarian notation
- Using `int.TryParse` instead of `Convert.ToInt32` so you can detect invalid input without having an exception

I know my code is really bad but im still learning yet I dont understand this message can anyone explain where I have went wrong

    private void btnCalculate_Click(object sender, EventArgs e)
    {
  //These are my variables which will take form of the values from the database and display whatever the user has input
  int iDay1, iDay2, iDay3, iDay4, iDay5, iDay6, iDay7;
  int iScore;
  iDay1 = Convert.ToInt32(txtBox1);
  iDay2 = Convert.ToInt32(txtBox2);
  iDay3 = Convert.ToInt32(txtBox3);
  iDay4 = Convert.ToInt32(txtBox4);
  iDay5 = Convert.ToInt32(txtBox5);
  iDay6 = Convert.ToInt32(txtBox6);
  iDay7 = Convert.ToInt32(txtBox7);
  iScore = Convert.ToInt32(iDay1 + iDay2 + iDay3 + iDay4 + iDay5 + iDay6 + iDay7);
  string Query = "insert into sql370447.calorie (day1, day2, day3, day4, day5, day6, day7) values('" + txtBox1.Text + "','" + txtBox2.Text + "','" + txtBox3.Text + "','" + txtBox4.Text + "','" + txtBox5.Text + "','" + txtBox6.Text + "','" + txtBox7.Text + "');";
  MySqlConnection myConn = new MySqlConnection(connStr);
  MySqlCommand cmdDataBase = new MySqlCommand(Query, myConn);
  MySqlDataReader myReader;
  myConn.Open();
  myReader = cmdDataBase.ExecuteReader();
  //A simple If statement to determine wether the user is healthy or not the users results will change depending on gender
  if (iScore >= 8000 && iScore <= 10000)
  {
      MessageBox.Show("Congratulations you are a Healthy male, your calorie intake is " + iScore);
  }
  else if (iScore >= 10001)
  {
      MessageBox.Show("You are eating more than you should be you are an unhealthy male, your calorie intake is " + iScore);
  }
  else
  {
      MessageBox.Show("You are eating way less than the healthy amount, you are an unhealthy male atm your calorie intake is " + iScore);
  }
    }


