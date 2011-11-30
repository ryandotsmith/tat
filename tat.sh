tat()
{
  local session_name="$1"
  tmux attach-session -t "$session_name"
  if [ $? -ne 0 ]; then
    local list_of_dirs=( $(find "$CODE_ROOT_DIR" -name "$session_name" -type d ) )
    local first_found="${dirs[0]}"
    cd "$first_found"
    echo "tat() is creating new tmux session with name=$session_name"
    tmux new-session -d -s "$session_name"
    echo "tat() is setting default path with dir=$first_found"
    tmux set default-path "$first_found"
    tmux attach-session -t "$session_name"
  fi
}
_tat()
{
  COMPREPLY=()
  local session="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=( $(compgen -W "$(tmux list-sessions 2>/dev/null | awk -F: '{ print $1 }')" -- "$session") )
}
complete -F _tat tat


