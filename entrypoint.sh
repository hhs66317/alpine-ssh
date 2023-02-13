#!/bin/zsh

# 兼容zsh
export DISABLE_AUTO_TITLE="true"

session="work"

tmux has-session -t $session
if [ $? = 0 ];then
#   tmux attach-session -t $session
    exit
fi

tmux -f /root/tmux.conf new -d -s $session

tmux renamew -t $session:1 task
tmux select-window -t $session:\task
tmux source-file ~/.tmux/tasklayout
# tmux send-keys -t $session:\task.1  'cd /root' C-m


tmux select-window -t $session:\task
# tmux attach-session -t $session

