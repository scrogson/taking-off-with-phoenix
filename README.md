# Taking Off with Phoenix

Please take a look at this list and make sure to install anything necessary for
your system. Having dependencies installed in advance will allow us to hit the
ground running and cover the most material possible.

## Installing dependencies

### Elixir

Phoenix is written in Elixir, and our application code will also be written in
Elixir. We won't get far in a Phoenix app without it! The Elixir site maintains
a great [Installation Page](http://elixir-lang.org/install.html) to help.

If we have just installed Elixir for the first time, we will need to install the
Hex package manager and Rebar as well. Hex is necessary to get a Phoenix app running (by
installing dependencies) and to install any extra dependencies we might need
along the way. Rebar is a similar tool used by many existing Erlang projects
that we may depend on.

Here's the command to install Hex and Rebar:

```console
$ mix local.hex
$ mix local.rebar
```

### Erlang

Elixir code compiles to Erlang byte code to run on the Erlang virtual machine.
Without Erlang, Elixir code has no virtual machine to run on, so we need to
install Erlang as well.

When we install Elixir using instructions from the Elixir [Installation Page](http://elixir-lang.org/install.html),
we will usually get Erlang too. If Erlang was not installed along with Elixir, please see the
[Erlang Instructions](http://elixir-lang.org/install.html#installing-erlang) section of
the Elixir Installation Page for instructions.

### node.js (>= 0.12.0)

Node is an optional dependency. Phoenix will use [brunch.io](http://brunch.io/)
to compile static assets (javascript, css, etc), by default. Brunch.io uses the
node package manager (npm) to install its dependencies, and npm requires
node.js.

We can get node.js from the [download page](https://nodejs.org/download/). When
selecting a package to download, it's important to note that Phoenix requires
version 0.12.0 or greater.

Mac OS X users can also install node.js via [homebrew](http://brew.sh/).

Note: io.js, which is an npm compatible platform originally based on Node.js, is
not known to work with Phoenix.

Debian/Ubuntu users might see an error that looks like this:
```console
sh: 1: node: not found
npm WARN This failure might be due to the use of legacy binary "node"
```
This is due to Debian having conflicting binaries for node: [discussion on
stackoverflow](http://stackoverflow.com/questions/21168141/can-not-install-packages-using-node-package-manager-in-ubuntu)

There are two options to fix this problem, either:

- install nodejs-legacy:
```console
$ apt-get install nodejs-legacy
```
or
- create a symlink
```console
$ ln -s /usr/bin/nodejs /usr/bin/node
```

### PostgreSQL

We will be interacting with a database while building our application. Phoenix
uses the database abstraction library [Ecto](https://github.com/elixir-lang/ecto)
which supports a number of databases.

For this workshop, we'll be using PostgreSQL for consistency across attendees.

The PostgreSQL wiki has [installation
guides](https://wiki.postgresql.org/wiki/Detailed_installation_guides) for
a number of different systems.

### inotify-tools (for linux users)

This is a Linux-only filesystem watcher that Phoenix uses for live code
reloading. (Mac OS X or Windows users can safely ignore it.)

Linux users need to install this dependency. Please consult the [inotify-tools wiki](https://github.com/rvoicilas/inotify-tools/wiki) for distribution-specific installation instructions.

### Phoenix

Once we have Elixir and Erlang, we are ready to install the Phoenix mix
archive. A mix archive is a zip file which contains an application as well as
its compiled beam files. It is tied to a specific version of the application.
The archive is what we will use to generate a new, base Phoenix application
which we can build from.

Here's the command to install the Phoenix archive for version 1.0.2:

```console
$ mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v1.0.2/phoenix_new-1.0.2.ez
```

> Note: if the Phoenix archive won't install properly with this command, we can
> download the file directly from our browser, save it to the filesystem, and
> then run: `mix archive.install /path/to/local/phoenix_new.ez`.

## Generating the application

We're going to generate a new Phoenix application to work with throughout this
workshop. We'll call it `support`. Navigate to a place on your filesystem where
you want to work from and run the following:

```console
$ mix phoenix.new support
* creating support/config/config.exs
* creating support/config/dev.exs
* creating support/config/prod.exs
* creating support/config/prod.secret.exs
...
* creating support/config/test.exs
* creating support/lib/support.ex
* creating support/lib/support/endpoint.ex
* creating support/mix.exs
* creating support/README.md
```

Make sure to say `Y` when prompted to fetch and install dependencies and follow
the directions in the console to get everything running.

```console
Fetch and install dependencies? [Yn] Y
* running npm install && node node_modules/brunch/bin/brunch build
* running mix deps.get

We are all set! Run your Phoenix application:

    $ cd support
    $ mix ecto.create
    $ mix phoenix.server

    You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phoenix.server
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser
and see your new Phoenix app running. Yay!

## Having trouble?

It is vital that we get all the setup dealt with prior to the workshop so that
we can focus on learning as much as possible with the limited time. Please feel
free to [contact me](mailto:scrogson@gmail.com) directly if you have any trouble
with getting anything setup.
