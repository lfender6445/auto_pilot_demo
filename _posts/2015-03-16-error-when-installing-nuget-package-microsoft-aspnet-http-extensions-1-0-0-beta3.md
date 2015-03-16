---
layout: post
title: "Error When installing NuGet package 'Microsoft.AspNet.Http.Extensions 1.0.0-beta3'"
description: ""
category:
tags: []
---

Error When installing NuGet package 'Microsoft.AspNet.Http.Extensions 1.0.0-beta3'


That package only has `aspnet50` and `aspnetcore50` directories within the `lib` directory. This means it's only suitable for ASP.NET vNext projects. You can't use it within a regular .NET 4.5 project - yet, at least.

If you're not using ASP.NET vNext, you should probably ignore it completely.

If you _are_ using ASP.NET vNext, you should check your `project.json` configuration file, and ensure that your configured runtimes are `aspnet50` and/or `aspnetcore50`.

Note that these runtime names are changing as a part of the grand k -> dnx rename.


When installing 'Microsoft.AspNet.Http.Extensions 1.0.0-beta3' I get this. I am trying to use it for iappbuilder reference so I can create an app with my app. Any ideas what could cause this?

    Install failed. Rolling back...
    Install-Package : Could not install package 'Microsoft.AspNet.Http.Extensions 1.0.0-beta3'. You are trying to install this package into a project that targets '.NETFramework,Version=v4.5', but the package does not contain any 
    assembly references or content files that are compatible with that framework. For more information, contact the package author.
    At line:1 char:1
    + Install-Package Microsoft.AspNet.Http.Extensions -Pre
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  + CategoryInfo : NotSpecified: (:) [Install-Package], InvalidOperationException
  + FullyQualifiedErrorId : NuGetCmdletUnhandledException,NuGet.PowerShell.Commands.InstallPackageCommand


