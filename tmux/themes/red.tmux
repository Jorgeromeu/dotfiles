#vim:ft=tmux

# status line
set -g status-justify left
set -g status-fg white
set -g status-bg black
set -g status-left '#[fg=black,bg=red,bold] #S #[bg=black] '
set -g status-right "#[fg=black, bg=red,bold] #H "

set -g window-status-format "#[fg=black,bg=brightred] #I #[fg=black, bg=brightred] #W "
set -g window-status-current-format "#[fg=black,bg=yellow, bold] #I #[fg=black, bg=brightred] #W "

# prompt
set -g message-style bg=black,fg=white

# borders
set -g pane-border-style fg=black
set -g pane-active-border-style fg=black

bind-key b set -g pane-active-border-style fg=red
bind-key B set -g pane-active-border-style fg=black

