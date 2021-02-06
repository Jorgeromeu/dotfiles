#vim:ft=tmux

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


# Shift arrow to switch windows
bind -n S-Left  previous-window
bind -n S-Right next-window
bind -n S-up swap-pane -U
bind -n S-down swap-pane -D


bind -n M-Left  resize-pane -L 5
bind -n M-Right resize-pane -R 5
bind -n M-up resize-pane -U 5
bind -n M-down resize-pane -D 5

# No delay for escape key press
set -sg escape-time 0

 
# enable mode
setw -g mouse on
 
# set simpler window split keys
bind-key v split-window -h -c "#{pane_current_path}"
bind-key h split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"

bind-key -n M-v split-window -h -c "#{pane_current_path}"
bind-key -n M-s split-window -v -c "#{pane_current_path}"

# no confirm for closing panes
bind-key x kill-pane

# vi copy mode 
set-window-option -g mode-keys vi
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

# vi mode in prompt
set -g status-keys vi

# Set the base index for windows and panes to 1
set -g base-index 1
set -g pane-base-index 1

# disable window auto-renaming
set-option -g allow-rename off

# enable auto window renumbering
set -g renumber-windows on

# easy config reload
bind-key r \
  source-file ~/.config/tmux/tmux.conf\;\
  source-file ~/.tmux.conf\;\
  display-message "config reloaded"

# toggle nested and local prefix
bind -T root F12  \
  set -g status off \;\
  set prefix None \;\
  set key-table off \;\
  if -F '#{pane_in_mode}' 'send-keys -X cancel' \;\
  refresh-client -S 

bind -T off F12 \
  set -g status on \;\
  set -u prefix \;\
  set -u key-table \;\
  set -u status-style \;\
  set -u window-status-current-style \;\
  set -u window-status-current-format \;\
  refresh-client -S
