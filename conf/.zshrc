HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
GPG_TTY=$(tty)
bindkey -e
zstyle :compinstall filename $HOME'/.zshrc'

autoload -Uz compinit
compinit

autoload -U colors
colors

autoload -Uz promptinit
promptinit
prompt redhat

bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
