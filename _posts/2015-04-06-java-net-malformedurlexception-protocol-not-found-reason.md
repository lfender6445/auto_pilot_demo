---
layout: post
title: "java.net.MalformedURLException: Protocol not found. Reason?"
description: ""
category:
tags: []
---

java.net.MalformedURLException: Protocol not found. Reason?


I am using this function :

    public void testing(String xml) throws ParserConfigurationException, SAXException, IOException{
      Log.d("TAG"," root.getNodeName()");
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
    
    
      Document document = builder.parse(xml);
    
    
      //document.getDocumentElement().normalize();
      //Element root = document.getDocumentElement();
      //Log.d("TAG", root.getNodeName());
      Log.d("TAG"," root.getNodeName()");
    
    
  }

And I am calling this function like this :

    testing(responseText)

Where response text is this:

    <?xml version='1.0' encoding='UTF-8'?>
    <queryresult success='true'
  error='false'
  numpods='2'
  datatypes=''
  timedout=''
  timedoutpods=''
  timing='0.751'
  parsetiming='0.216'
  parsetimedout='false'
  recalculate='http://www4b.wolframalpha.com/api/v2/recalc.jsp?id=MSPa2715236aaf6db55age00000025hbhc18c61h80c4&amp;s=10'
  id='MSPa2716236aaf6db55age00000019f566b957ic219h'
  host='http://www4b.wolframalpha.com'
  server='10'
  related='http://www4b.wolframalpha.com/api/v2/relatedQueries.jsp?id=MSPa2717236aaf6db55age000000535a701459c5c90a&amp;s=10'
  version='2.6'>
     <pod title='Input interpretation'
   scanner='Identity'
   id='Input'
   position='100'
   error='false'
   numsubpods='1'>
<subpod title=''>
 <plaintext>Tell me a joke.</plaintext>
</subpod>
     </pod>
     <pod title='Result'
   scanner='Data'
   id='Result'
   position='200'

But im getting the error:

> 04-06 22:19:14.348: D/TAG(30413): java.net.MalformedURLException: Protocol not found:

What am I doing wrong ?

Note that I am getting this responseText from a server. So if theres any problem with the xml itself, do tell me how to manipulate the string, instead of suggesting me to change the xml itself.


--------------------------------------- 
The problem is that you're passing in the XML content itself - but `DocumentBuilder.parse(String)` accepts a _URL_ to load the XML from - not the content itself.

You probably want to use `DocumentBuilder.parse(InputSource)` instead, having created an `InputSource` from a `StringReader` wrapping the XML:

    Document document = builder.parse(new InputSource(new StringReader(xml)));


