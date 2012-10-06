# Practise  basic Ruby constructs

This repository contains some quests to be solved using basic Ruby
syntax. Run the server and try to solve the problems described there.

## How to run the server

```
# haven't tested on Windows, there migth be some additional packages
# and compiler needed
bundle install 
ruby courseboard.rb
```

The server should be running on `http://localhost:4567`

You need the server only for the Quest 4. Otherwise it's ok just to open
`public/index.html` page.

## Solutions

The solutions are in directories `quest#n`. In Ruby there are often more
ways how to write things. Therefore there might be more files (with
suffixes such as `_long`, `_medium`, `_short`). Usually, the shorter
versions use some more advanced Ruby feature. I recommend to compare the
differences to learn something new.

You might be also intereted in the way the server is written. It's just
a few lines of code, that provide a basic websockets features, using
`sinatra` and `sinatra-websocket` gems.
