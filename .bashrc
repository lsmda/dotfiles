# Check if we're not already in a TMUX session, and if this is an interactive shell
if [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    # Check if tmux is available on the system
    if command -v tmux &> /dev/null; then
        # Start tmux
        tmux
    else
        echo "tmux not installed. Please install tmux to use it automatically."
    fi
fi
