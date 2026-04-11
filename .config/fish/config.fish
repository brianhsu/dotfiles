if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Command Alias
alias ls lsd

# Set Fisher prompt
set --global fish_greeting
set --global tide_context_always_display true
set --global tide_left_prompt_items os context pwd gitadv newline character
set --global tide_right_prompt_items status cmd_duration jobs direnv node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig
