#vim:ft=tmux

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

# use Alv-arrows to resize panes
bind -n M-Left  resize-pane -L 5
bind -n M-Right resize-pane -R 5
bind -n M-up resize-pane -U 5
bind -n M-down resize-pane -D 5

# No delay for escape key press
set -sg escape-time 0
 
# enable mouse
setw -g mouse on

# set simpler pane split keys
# h -> split horizontally
# v -> split vertically
#
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


# THEME
# =====

# theme
source "~/dotfiles/tmux/themes/blue.tmux"


# status line
set -g status-justify left
set -g status-fg white
set -g status-bg black
set -g status-left '#[fg=black,bg=blue,bold] #S #[bg=black] '
set -g status-right "#[fg=black, bg=blue,bold] #H "

set -g window-status-format "#[fg=black,bg=cyan] #I #[fg=black, bg=cyan] #W "
set -g window-status-current-format "#[fg=black,bg=yellow, bold] #I #[fg=black, bg=cyan] #W "

# prompt
set -g message-style bg=black,fg=white

# borders
set -g pane-border-style fg=black
set -g pane-active-border-style fg=black

bind-key b set -g pane-active-border-style fg=blue
bind-key B set -g pane-active-border-style fg=black

