# Disable greeting
set fish_greeting

# Check if TMUX is unset or empty and if the session is interactive
if test -z "$TMUX" && status is-interactive
  # Check if any Tmux sessions exist
  set tmux_sessions (tmux list-sessions)
  if test -z "$tmux_sessions"
    # If no sessions exist, start a new Tmux session
    tmux new-session
  else
    # If sessions exist, attach to the first one
    tmux attach-session -t (echo $tmux_sessions[1] | cut -d: -f1)
  end
end
