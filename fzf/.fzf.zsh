# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vivekrai/.fzf/bin* ]]; then
  export PATH="$PATH:/home/vivekrai/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/vivekrai/.fzf/man* && -d "/home/vivekrai/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/vivekrai/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/vivekrai/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/vivekrai/.fzf/shell/key-bindings.zsh"

