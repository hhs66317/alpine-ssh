set -o allexport
bindkey -e
LC_CTYPE=en_US.UTF-8
LANG=en_US.UTF-8

autoload -Uz promptinit
promptinit
prompt adam1
alias ll='ls -alh --color=auto'
