---
layout: post
title: "Java .jar executable not opening (on double click)"
description: ""
category:
tags: []
---

Java .jar executable not opening (on double click)


I wrote a little command-line game that has 5 classes: the main class "DiaDia.class", and the others "Partita.class", "Comando.class", "Stanza.class", "Attrezzo.class". Then i created a diadiamanifest.txt file so:

    Main-Class: DiaDia

ending file with a new line. I tried to make a DiaDia.jar file with 2 different commands:

    jar cvfm DiaDia.jar diadiamanifest.txt DiaDia.class Partita.class Comando.class Stanza.class Attrezzo.class
    
    
    
    
    jar cvfe DiaDia.jar DiaDia DiaDia.class Partita.class Comando.class Stanza.class Attrezzo.class

In both cases the generated DiaDia.jar file runs well with the command:

    java -jar DiaDia.jar

but does nothing with a double click on it. I set properly the file association of .jar extension to

    C:\Program Files\Java\jre7\bin\javaw.exe

I run Windows 7 Home Premium x64, with jre7 update 76 and jdk1.7.0\_76.


--------------------------------------- 
> I wrote a little command-line game

That's the problem then.

`javaw.exe` is designed to run GUI applications - it doesn't allocate a console. If you change the file association for `.jar` to run `java.exe` instead, it will launch a console and your app will run. On the other hand, anything _else_ that's designed to run as a launchable jar file - most of which _will_ have GUIs - will end up launching a console even if you don't want one.

Alternatively, change your game to not need a console, or just run it from a command line using `java -jar ...` which, as you've already said, works fine.


