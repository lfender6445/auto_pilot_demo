---
layout: post
title: "What is a “localized message”?"
description: ""
category:
tags: []
---

What is a “localized message”?


I have seen in several languages that (especially exceptions) offer _message_ and _localised message_ methods. But it is not clear to me what the difference is - do any of the following apply?

1. The _localized message_ is for child classes to use. Why wouldn't they override the primary _message_?
2. Is this a physical location thing where the same _message_ may be presented based on things like locale, timezone, etc.

Furthermore when should the _localized message_ be preferred over the regular _message_? Or conversely, not?


--------------------------------------- 
This one:

> Is this a physical location thing where the same message may be presented based on things like locale, timezone, etc.

Although it's usually just locale / culture, really.

Basically imagine that an error message of "The value must be greater than 0" might be represented as "La valeur doit être supérieure à 0" for French developers (courtesy of Google Translate; may not be idiomatic as an error message).

This is just applying the general concept of localization (making your code communicate in the language/culture of your user) to a specific case of error messages though.


