TAT(1)

## Name
 tat - tmux attach utility

## Synopsis

**tat [session_name | new_session_name]**

## Description

Tab completion for tmux sessions.

Quickly open new tmux sessions in your project's dir.

## Setup

```bash
git clone git://github.com/ryandotsmith/tat.git ~/path/to/tat
echo "source ~/path/to/tat/tat.sh" >> ~/.bashrc
echo "export CODE_ROOT_DIRS=\"/home/you/code\"" >> ~/.bashrc
echo "export CODE_ROOT_DIRS=\"/home/you/other_code_dir:$CODE_ROOT_DIRS\"" >> ~/.bashrc
```

## Usage

Use the tab key to open an existing session.

```bash
$ tat [TAB]
open_session_1 open_session_2
```

Arguments that are passed to tat will be used to create a new session.
Tat will open a new tmux session and set the default path to the found dir.

```bash
$ tat my_project
$ pwd
/home/you/code/my_project
```

## Motivation

There are popular tmux helpers on github. They require ruby and yaml file. No thanks! 
It is my opinion that bash is the right tool for the job here. UNIX doesn't care about yaml.

## Issues

tat(1) assumes you have your code in a "root" dir; we use find(1) on this directory and there is not depth limit.
Thus find may take a while. I think the use of find(1) could be tuned for better performance.

**update**

I have piped the output of find to head(1) -n 1. This is a bit of a hack, but head will close our pipe on the first result
which will cause find to error out.


