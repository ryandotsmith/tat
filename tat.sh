tat() {
  local session_name="$1"
  local sessions=( $(tmux list-sessions 2>/dev/null | cut -d ":" -f 1 | grep "^$session_name$") )

  if [ ${#sessions[@]} -gt 0 ]; then
    # If there is already a session with the same name, attach to it.
    tmux attach-session -t "$session_name"
  else
    # If there is no existing session, create a new (detached) one.
    tmux new-session -d -s "$session_name"

    # Try to find a matching code directory.
    local code_root_dirs=$(echo $CODE_ROOT_DIRS | sed 's/:/ /g')
    local matching_dirs=( $(find $code_root_dirs -maxdepth 1 -name "$session_name" -type d ) )

    # If there is a matching directory, set it as the default path and jump into the directory.
    if [ ${#matching_dirs[@]} -gt 0 ]; then
      local code_dir=${matching_dirs[0]}
      tmux set default-path "$code_dir" 1>/dev/null
      tmux send-keys -t "$session_name:1" "cd $code_dir && clear" C-m

      # If there is a .tmux file in this directory, execute it.
      if [ -f "$code_dir/.tmux" ]; then
        eval "$code_dir/.tmux" $session_name
      fi
    fi

    # Finally, attach to the newly created session.
    tmux attach-session -t "$session_name"
  fi
}

_tat() {
  COMPREPLY=()
  local session="${COMP_WORDS[COMP_CWORD]}"
  local code_root_dirs=$(echo $CODE_ROOT_DIRS | sed 's/:/ /g')

  # For autocomplete, use both existing sessions as well as directory names.
  local sessions=( $(compgen -W "$(tmux list-sessions 2>/dev/null | awk -F: '{ print $1 }')" -- "$session") )
  local directories=( $(
  for dir in $code_root_dirs; do
    cd "$dir" 2 >/dev/null && compgen -d -- "$session"
  done
  ) )

  COMPREPLY=( ${sessions[@]} ${directories[@]} )
}

complete -o filenames -o nospace -F _tat tat
