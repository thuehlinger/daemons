Ruby Daemons
============

Daemons provides an easy way to wrap existing ruby scripts (for example a self-written server)
to be _run as a daemon_ and to be _controlled by simple start/stop/restart commands_.

If you want, you can also use daemons to _run blocks of ruby code in a daemon process_ and to control
these processes from the main application.

Besides this basic functionality, daemons offers many advanced features like _exception backtracing_
and logging (in case your ruby script crashes) and _monitoring_ and automatic restarting of your processes
if they crash.

Basic Usage
-----------

You can use Daemons in four different ways:

### 1. Create wrapper scripts for your server scripts or applications

Layout: suppose you have your self-written server `myserver.rb`:

``` ruby
# this is myserver.rb
# it does nothing really useful at the moment

loop do
  sleep(5)
end
```

To use `myserver.rb` in a production environment, you need to be able to
run `myserver.rb` in the _background_ (this means detach it from the console, fork it
in the background, release all directories and file descriptors).

Just create `myserver_control.rb` like this:

``` ruby
# this is myserver_control.rb
require 'daemons'

Daemons.run('myserver.rb')
```

And use it like this from the console:

``` ruby
$ ruby myserver_control.rb start
    (myserver.rb is now running in the background)
$ ruby myserver_control.rb restart
    (...)
$ ruby myserver_control.rb stop
```

For testing purposes you can even run `myserver.rb` _without forking_ in the background:

``` ruby
$ ruby myserver_control.rb run
```

An additional nice feature of Daemons is that you can pass _additional arguments_ to the script that
should be daemonized by seperating them by two _hyphens_:

``` ruby
$ ruby myserver_control.rb start -- --file=anyfile --a_switch another_argument
```


### 2. Create wrapper scripts that include your server procs

Layout: suppose you have some code you want to run in the background and control that background process
from a script:

``` ruby
# this is your code
# it does nothing really useful at the moment

loop do
  sleep(5)
end
```

To run this code as a daemon create `myproc_control.rb` like this and include your code:

``` ruby
# this is myproc_control.rb
require 'daemons'

Daemons.run_proc('myproc.rb') do
  loop do
    sleep(5)
  end
end
```

And use it like this from the console:

``` ruby
$ ruby myproc_control.rb start
    (myproc.rb is now running in the background)
$ ruby myproc_control.rb restart
    (...)
$ ruby myproc_control.rb stop
```

For testing purposes you can even run `myproc.rb` _without forking_ in the background:

``` ruby
$ ruby myproc_control.rb run
```

### 3. Control a bunch of daemons from another application

Layout: you have an application `my_app.rb` that wants to run a bunch of
server tasks as daemon processes.

``` ruby
# this is my_app.rb
require 'daemons'

task1 = Daemons.call(:multiple => true) do
  # first server task

  loop do
    conn = accept_conn()
    serve(conn)
  end
end

task2 = Daemons.call do
  # second server task

  loop do
    something_different()
  end
end

# the parent process continues to run

# we can even control our tasks, for example stop them
task1.stop
task2.stop

exit
```

### 4. Daemonize the currently running process

Layout: you have an application `my_daemon.rb` that wants to run as a daemon
(but without the ability to be controlled by daemons via start/stop commands)

``` ruby
# this is my_daemons.rb
require 'daemons'

# Initialize the app while we're not a daemon
init()

# Become a daemon
Daemons.daemonize

# The server loop
loop do
  conn = accept_conn()
  serve(conn)
end
```

For further documentation, refer to the module documentation of Daemons.

Author
------

Written 2005-2013 by Thomas Uehlinger <th.uehlinger@gmx.ch>
