# auto_pilot demo application

[auto_pilot](http://www.github.com/lfender6445/auto_pilot) allows you to convert your stackoverflow profile to a jekyll ready blog

# install

1. `bundle install`
2. `bundle exec jekyll serve`
3. visit [localhost:4000](http://localhost:4000) to see the app in action

# screenshots
![view all posts](http://i.imgur.com/S6z3NjI.png)
![view single post](http://i.imgur.com/6LZsDEH.png)

# how do I

## integrate autopilot?

1. [add auto_pilot as development dependency](https://github.com/lfender6445/auto_pilot_demo/blob/master/Gemfile#L7)
2. run `bundle exec autopilot`
3. enter a stackoverflow username
4. create and update [configuration](https://github.com/lfender6445/auto_pilot_demo/blob/master/auto_pilot_config.rb)
5. resume by running `bundle exec autopilot`

## customize templates?
- we can update our configuration (generated at runtime) with an override of `MarkdownConverter#md_template`
- [example](https://github.com/lfender6445/auto_pilot_demo/blob/custom_templates/auto_pilot_config.rb#L21)
