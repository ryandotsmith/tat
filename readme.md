# tat(1)
Tab completion for tmux sessions.
Quickly open new tmux sessions in your projects dir.

## Setup

```bash
source tat.sh
export CODE_ROOT_DIR=/home/you/code
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


