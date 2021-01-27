#vim:ft=tmux

# status line
set -g status-justify left
set -g status-fg white
set -g status-bg black
set -g status-left '#[fg=black,bg=purple,bold] #S #[bg=black] '
set -g status-right "#[fg=black, bg=purple,bold] #H #[bg=black] #[fg=black,bg=yellow,bold]#(uptime | cut -f 4-5 -d ' ' | cut -f 1 -d ',') "

set -g window-status-format "#[fg=black,bg=cyan] #I #[fg=black, bg=cyan] #W "
set -g window-status-current-format "#[fg=black,bg=yellow, bold] #I #[fg=black, bg=cyan] #W "

# prompt
set -g message-style bg=black,fg=white

# borders
set -g pane-border-style fg=black
set -g pane-active-border-style fg=black

bind-key b set -g pane-active-border-style fg=purple
bind-key B set -g pane-active-border-style fg=black


