unbind-key -n C-a
set -g prefix ^E

bind-key -n ^N new-window -c "#{pane_current_path}" \; rename-window "-"
bind-key -n ^H previous-window
bind-key -n ^L next-window
bind-key -n ^B copy-mode

unbind p
bind p paste-buffer
bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
bind-key -T copy-mode-vi 'y' send-keys -X copy-selection-and-cancel


bind-key -n ^T command-prompt -p "(rename-window) " "rename-window '%%'"





