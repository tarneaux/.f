__dir_to_tmux_session_name() {
	local dir="${PWD##*/}"
	# Remove all non-alphanumeric characters and replace them with underscores
	dir="${dir//[^[:alnum:]]/_}"

	echo "$dir"
}

rtmux() {
	local session_name="$(__dir_to_tmux_session_name)"

	# Verify we are in a Rust project
	[[ -f Cargo.toml ]] || { echo "Not a Rust project" && return 1; }

	# Try to attach to an existing session
	tmux attach-session -t "$session_name" && return 0

	# If no session exists, create one & open it
	tmux new-session -d -s "$session_name" "nvim src/"
	tmux split-window -h "bacon"
	tmux split-window -v
	tmux select-pane -t 0
	tmux attach-session -d -t "$session_name"
}

htmux() {
    if ! command -v hugo &> /dev/null ; then
        nix-shell -p hugo --command "SHELL=$SHELL zsh -ic htmux"
        return
    fi

	local session_name="$(__dir_to_tmux_session_name)"

	# Verify we are in a Hugo project
	[[ -f config.toml ]] || [[ -f config.yaml ]] || [[ -f hugo.yaml ]] || [[ -f hugo.toml ]] || { echo "Not a Hugo project" && return 1; }

	# Try to attach to an existing session
	tmux attach-session -t "$session_name" && return 0

    # Open web browser when server is ready
    {
        while true; do
            curl -s http://localhost:1313 > /dev/null && break
            sleep 0.5
        done
        xdg-open http://localhost:1313 > /dev/null 2>&1
    } &!

    # If no session exists, create one & open it
	tmux new-session -d -s "$session_name" "nvim content/"
	tmux split-window -h
	tmux new-window "hugo server -D --disableFastRender"
	tmux select-window -t 0
	tmux attach-session -d -t "$session_name"
}

ntmux() {
	local session_name="$(__dir_to_tmux_session_name)"

	# Verify we are in a Hugo project
	[[ -f package.json ]] || { echo "Not a NodeJS project" && return 1; }

	# Try to attach to an existing session
	tmux attach-session -t "$session_name" && return 0

	# If no session exists, create one & open it
	tmux new-session -d -s "$session_name" "nvim ."
	tmux split-window -h
	tmux new-window "npm run dev"
	tmux select-window -t 0
	tmux attach-session -d -t "$session_name"
}
