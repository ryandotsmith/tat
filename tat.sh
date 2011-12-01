tat()
{
  local session_name="$1"
  tmux attach-session -t "$session_name"
  if [ $? -ne 0 ]; then
    local code_root_dirs=$(echo $CODE_ROOT_DIRS | sed 's/:/ /g')
    local list_of_dirs=( $(find $code_root_dirs -name "$session_name" -type d -maxdepth 1 ) )
    echo "tat() found the following dirs: $list_of_dirs"
    echo "tat() is using dir = ${list_of_dirs[0]}"
    local first_found="${list_of_dirs[0]}"
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


