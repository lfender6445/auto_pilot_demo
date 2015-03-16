---
layout: post
title: "How can I diagnose missing dependencies (or other loader failures) in dnx?"
description: ""
category:
tags: []
---

How can I diagnose missing dependencies (or other loader failures) in dnx?


I still don't know _entirely_ what was wrong, but I now have a series of steps to at least make it easier to try things:

- When in doubt, reinstall dnx
  - Blowing away the package cache can be helpful

- Check `~/.config/NuGet.config` to ensure you're using the right NuGet feeds

I ended up using the following command line to test various options in a reasonably clean way:

    rm -rf ~/.dnx/packages && rm -rf ~/.dnx/runtimes && dnvm upgrade && kpm restore && dnx . kestrel

It looks like my problem was really due to the wrong versions of the dependencies being installed. A version number of `"1.0.0-beta4"` is apparently quite different to `"1.0.0-beta4-*"`. For example, the `Kestrel` dependency installed version 1.0.0-beta4-11185 when just specified as `1.0.0-beta4`, but version 1.0.0-beta4-11262 with the `-*` at the end. I wanted to specify `beta4` explicitly to avoid accidentally using a beta3 build with the

The following project config works fine:

    {
"dependencies": {
  "Kestrel": "1.0.0-beta4-*",
  "Microsoft.AspNet.Diagnostics": "1.0.0-beta4-*",
  "Microsoft.AspNet.Hosting": "1.0.0-beta4-*",
  "Microsoft.AspNet.Server.WebListener": "1.0.0-beta4-*",
},
"commands": {
  "kestrel": "Microsoft.AspNet.Hosting --server Kestrel --server.urls http://localhost:5004"
},
"frameworks": {
  "dnx451": {}
}
    }


I'm trying to run a modified version of the [HelloWeb sample](https://github.com/aspnet/Home/tree/master/samples/HelloWeb) for ASP.NET vNext on DNX using Kestrel. I understand that this is _very_ much on the bleeding edge, but I would hope that the ASP.NET team would at least keep the simplest possible web app working :)

Environment:

- Linux (Ubuntu, pretty much)
- Mono 3.12.1
- DNX 1.0.0-beta4-11257 (I have 11249 available too)

"Web app" code, in `Startup.cs`:

    using Microsoft.AspNet.Builder;
    public class Startup
    {
  public void Configure(IApplicationBuilder app)
  {
      app.UseWelcomePage();
  }
    }

Project config, in `project.json`:

    {
"dependencies": {
  "Kestrel": "1.0.0-beta4",
  "Microsoft.AspNet.Diagnostics": "1.0.0-beta4",
  "Microsoft.AspNet.Hosting": "1.0.0-beta4",
  "Microsoft.AspNet.Server.WebListener": "1.0.0-beta4",
  "Microsoft.AspNet.StaticFiles": "1.0.0-beta4",
  "Microsoft.Framework.Runtime": "1.0.0-beta4",
  "Microsoft.Framework.Runtime.Common": "1.0.0-beta4",
  "Microsoft.Framework.Runtime.Loader": "1.0.0-beta4",
  "Microsoft.Framework.Runtime.Interfaces": "1.0.0-beta4",
},
"commands": {
  "kestrel": "Microsoft.AspNet.Hosting --server Kestrel --server.urls http://localhost:5004"
},
"frameworks": {
  "dnx451": {}
}
    }

`kpm restore` appears to work fine.

When I try to run, however, I get an exception suggesting that `Microsoft.Framework.Runtime.IApplicationEnvironment` can't be found. Command line and error (somewhat reformatted)

    .../HelloWeb$ dnx . kestrel
    System.IO.FileNotFoundException: Could not load file or assembly 
    'Microsoft.Framework.Runtime.IApplicationEnvironment,
Version=0.0.0.0, Culture=neutral, PublicKeyToken=null'
    or one of its dependencies.
    File name: 'Microsoft.Framework.Runtime.IApplicationEnvironment,
Version=0.0.0.0, Culture=neutral, PublicKeyToken=null'
at (wrapper managed-to-native) System.Reflection.MonoMethod:InternalInvoke 
  (System.Reflection.MonoMethod,object,object[],System.Exception&)
at System.Reflection.MonoMethod.Invoke 
  (System.Object obj, BindingFlags invokeAttr, System.Reflection.Binder binder,
   System.Object[] parameters, System.Globalization.CultureInfo culture)
  [0x00000] in <filename unknown>:0

While obviously my most pressing need is to fix this, I'd also appreciate advice on how to move diagnose what's going wrong so I can fix similar issues myself in the future. (That's also likely to make this question more useful to others, too.)

I've found `Microsoft.Framework.Runtime.IApplicationEnvironment` in the [`Microsoft.Framework.Runtime.Interfaces` assembly source](https://github.com/aspnet/DNX/blob/dev/src/Microsoft.Framework.Runtime.Interfaces/IApplicationEnvironment.cs), and that doesn't appear to have changed recently. It's not clear why the exception shows the name as if it's a whole assembly in itself, rather than just an interface within another assembly. I'm guessing this _may_ be due to [assembly neutral interfaces](https://github.com/aspnet/Home/wiki/Assembly-Neutral-Interfaces), but it's not clear from the error. ( [`[AssemblyNeutral]` is dead, so that's not it...](https://github.com/aspnet/DNX/commit/5f8bf5614d04b82dc69aedf48a5b2f832f00ca8f))


