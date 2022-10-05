# IP support programs

This directory contains two support programs for IP:

 - `ref_node`: This is the reference version of the IP node you will be
   building.  Your node should be able to interoperate with this one.

 - `net2lnx`: Utility for converting .net files (which describe a
   virtual network) into .lnx files (input to run each node)

 - `run_net`:  Script for running all nodes in a network in one terminal

**Note for M1 mac users**: This directory contains x86 code which will
  not run on your system.  Instead, see the `arm64` directory for
  versions of `ref_node` and `net2lnx` compiled for your architecture.
  (`run_net` is just a script and will run on any architecture)


## `ref_node`

`ref_node` is a reference implementation of the node you will build in
the IP assignment.  To run it:
```
$ ref_node <lnx file>
```

Optionally, you can pass the argument `-no-checksum` to disable IP
checksum validation (helpful for debugging!)

## `net2lnx`

`net2lnx` creates `.lnx` files that you will pass to each of your nodes
on startup.  `.lnx` files are generated from a `.net` file describing
the network architecture.

This program will generate one `.lnx` file per node in the current
directory.  You may find it helpful to make a new directory first to
contain these files.  For example (starting from the repository root):
```sh
$ ls  # Start from repo root
nets rip_dissector tools utils

user@host:~/repo$ mkdir ABC  
user@host:~/repo$ cd ABC
user@host:~/repo/ABC$ ../tools/net2lnx ../nets/ABC.net  # Run net2lnx from here
user@host:~/repo/ABC$ ls
A.lnx B.lnx C.lnx  # lnx files!
```

Now you can use these files to run a node:
```sh
user@host:~/repo$ ./node ABC/A.lnx
```

**OR**

```sh
user@host:~/repo$ tools/ref_node ABC/A.lnx
```

### Source code

The source code for this program has been provided, but you should not
need to view or change it.  Rather, if the compiled version of the
program provided doesn't work on your platform, you can rebuild it
with `make`.

## `run_net`

This script automatically launches node processes for all nodes in a
virtual network in a tmux session.  tmux is a terminal multiplexer, a
program that allows you to run multiple processes in the same terminal
and navigate between them.

You can invoke `run_net` as follows:
```
run_net <path to node_program> <dir with lnx files>
```

For example (where your binary is called `node`):
```sh
user@host:~/repo$ ls ABC
A.lnx   B.lnx   C.lnx

user@host:~/repo$ run_net node ABC
```

You can also use `run_net` with the reference node!  For example:
```
user@host:~/repo$ run_net tools/ref_node ABC
```

`run_net` will create a tmux session with one pane for each node.  If
you are new to tmux, you can get started using it in just a few
minutes--however, a full tutorial on tmux is beyond the scope of this
readme.  The next section outlines some important commands, though.

For more resources on using tmux, take a look at the following:
  - https://tmuxcheatsheet.com/quick-start/
  - https://tmuxcheatsheet.com/
  - https://www.howtogeek.com/671422/how-to-use-tmux-on-linux-and-why-its-better-than-screen/
  - tmux's man page (man tmux)

**Note**: Since our nodes run with fixed port numbers defined in the
lnx files, you can't run more than one of the same node at the same
time (unless you manually edit the lnx files).  If you get errors
about duplicate tmux sessions or nodes fail to start, run `run_net`
with the `--clean` option, ie. `run_net --clean node ...`.  


### Most important tmux commands for working with `run_net`

Commands in tmux are typically in the form of `Ctrl+b` `KEY`.  This
means you should first press `Ctrl+b`, release, and then press the
next key.  `Ctrl+b` is known as an "escape sequence" that tells tmux
that your input is a tmux command and not input for the terminal.  

We think the following tmux commands are most useful for this project:
 - `Ctrl+b` `o`:  Cycle between panes
 - `Ctrl+b` `space`:  Cycle various pane layouts
 - `Ctrl+b` `<number key>`:  Switch directly to pane number N
 - `Ctrl+b` `:`, then type `kill session` `<Enter>`:  Kill the session (and all nodes)
 - `Ctrl+b` `d`:  Detach the session (but leave it running), reattach
 with `tmux attach`
 