Pipsqueak
=========

A simple stat app you can run on your own server.

To build thrift on OS X
-----------------------
```
bundle config build.thrift --with-cppflags='-D_FORTIFY_SOURCE=0'
```

Initialize DB
-------------
```
rake db:create
```
