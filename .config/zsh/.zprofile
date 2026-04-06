emulate sh -c 'source /etc/profile'
source $HOME/.config/shell/profile

# zsh syntax alias

# head / tail shortcuts
alias \
    -g H='| uu-head' \
    -g T='| uu-tail' \
    -g G='| grep' \
    -g L="| less" \
    -g M="| most" \
    -g LL="2>&1 | less" \
    -g CA="2>&1 | cat -A" \
    -g NE="2> /dev/null" \
    -g NUL="> /dev/null 2>&1" \
    -g P="2>&1| pygmentize -l pytb"

# functions

# Find and edit using fzf
fe() {
  nvim "$(fd -type f | fzf --preview 'cat {}' --preview-window 'up:60%')"
}

frg() {
  RG_PREFIX="rga --files-with-matches"
  local file
  file="$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
      fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
        --phony -q "$1" \
        --bind "change:reload:$RG_PREFIX {q}" \
        --preview-window="70%:wrap"
  )" &&
  echo "opening $file" &&
  xdg-open "$file"
}

pe() {
  local file
  file=$(fd ~/.password-store -type f -name '*.gpg' | sed "s|^$HOME/.password-store/||;s|\.gpg$||" | fzf)
  if [ -n "$file" ]; then
    pass edit "$file"
  fi
}

# Find and remove files with fzf
frm() {
  # Use `find` to list files and directories, and pipe them to `fzf` for selection
  selected=$(fd . -type f -o -type d 2>/dev/null | fzf -m)

  # Check if any selection was made
  if [[ -n "$selected" ]]; then
    # Echo the files or directories that will be deleted
    echo "Deleting the following files or directories:"
    echo "$selected"

    # Use `xargs` to safely pass selected files/directories to `rm -rf`
    echo "$selected" | xargs -d '\n' rm -rf
  else
    echo "No files or directories selected."
  fi
}

ssh_fzf() {
  local host=$(grep "Host " ~/.ssh/config | cut -d " " -f 2 | fzf)
  if [[ -n $host ]]; then
    ssh "$host"
    else
      echo "No host selected"
    fi
}

open_with_fzf() {
    fd -t f -H -I | fzf --preview="bat {}" | xargs -ro -d "\n" xdg-open 2>&-
}

cd_with_fzf() {
    z "$(fd -t d -H -I | fzf --preview='tree -L 1 {}' --bind="space:toggle-preview" --preview-window=:hidden)"
}
