
# DevX tmux config
#vim:ft=tmux
# =================
# MACHINE-SPECIFIC SETTINGS
# =================
# theme color (default; hosts can override in ~/.tmux.local.conf)
set -g @active_window_color "blue"
source-file -q ~/.tmux.local.conf
# GENERAL SETTINGS
# =================
# set TERM
set -g default-terminal "tmux-256color"
# Use Alt-vim keys to switch and resize panes
bind -n M-h select-pane -L
bind -n M-j select-pane -D
bind -n M-k select-pane -U
bind -n M-l select-pane -R
bind -n M-H resize-pane -L 5
bind -n M-J resize-pane -D 5
bind -n M-K resize-pane -U 5
bind -n M-L resize-pane -R 5
# use <, > for swapping paes
bind > swap-pane -D       
bind < swap-pane -U       
# use Alt-arrows to resize panes
bind -n M-Left  resize-pane -L 5
bind -n M-Right resize-pane -R 5
bind -n M-up resize-pane -U 5
bind -n M-down resize-pane -D 5
 
# enable mouse
setw -g mouse on
# set simpler pane split keys
# h -> split horizontally
# v -> split vertically
# also, new windows/panes will open in the wd of the current pane
bind-key v split-window -h -c "#{pane_current_path}"
bind-key h split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"
# no confirm for closing panes
bind-key x kill-pane
# vi copy mode 
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
# vi mode in prompt
set -g status-keys vi
# Set the base index for windows and panes to 1 rather than 0
set -g base-index 1
set -g pane-base-index 1
# enable auto window renumbering
set -g renumber-windows on
# make F12 toggle between parent and nested session
bind -T root F12  \
  set prefix None \;\
  set key-table off \;\
  set -g status-style fg=brightblack,bg=default \;\
  set -g window-status-current-style fg=brightblack,bg=default \;\
  set -g window-status-current-format "#[fg=brightblack,bg=default]#I:#W" \;\
  if -F '#{pane_in_mode}' 'send-keys -X cancel' \;\
  refresh-client -S 
bind -T off F12 \
  set -u prefix \;\
  set -u key-table \;\
  set -g status-style fg=white,bg=default \;\
  set -g window-status-current-style fg=blue,bg=default,bold \;\
  set -g window-status-current-format "#[fg=blue,bg=default,bold]#I:#W" \;\
  refresh-client -S
# Make `prefix r` reload the config file
unbind r
bind r source-file ~/.tmux.conf \; display-message "tmux config reloaded!"
# =================
# STATUS LINE
# =================
set -g status-style fg=white,bg=default
set -g status-justify left
# left: session name with padding
set -g status-left "#S "
# right: hostname
set -g status-right "#H"
# windows: no spacing between them
set -g window-status-format "#[fg=grey,bg=default]#I:#W"
set -g window-status-current-format "#[fg=#{@active_window_color},bg=default,bold]#I:#W"
# messages / prompts
set -g message-style fg=white,bg=default
# Pane Borders
run-shell "tmux set -g pane-active-border-style fg=$(tmux show-option -gv @active_window_color)"
set -g pane-border-style fg=black
