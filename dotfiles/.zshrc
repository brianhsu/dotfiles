export TERM="xterm-256color"
export ZSH=/usr/share/oh-my-zsh
export FZF_DEFAULT_COMMAND='ag -g ""'
export PATH=$PATH:~/.local/bin
export GUNDAM_DB_PASSWD="4735821"

[[ $startup_cmd ]] && {
    declare +x startup_cmd
    eval "$startup_cmd"
}

ZSH_THEME="powerlevel9k/powerlevel9k"

CASE_SENSITIVE="true"

POWERLEVEL9K_MODE="awesome-fontconfig"
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_LOCK_ICON=''
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=true
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
POWERLEVEL9K_NVM_BACKGROUND="238"
POWERLEVEL9K_NVM_FOREGROUND="green"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="blue"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="015"
POWERLEVEL9K_TIME_BACKGROUND='255'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='245'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs custom_inbox custom_next)
POWERLEVEL9K_SHOW_CHANGESET=false

POWERLEVEL9K_CUSTOM_INBOX="echo `task +inbox +PENDING count` "
POWERLEVEL9K_CUSTOM_INBOX_BACKGROUND="white"
POWERLEVEL9K_CUSTOM_INBOX_FOREGROUND="black"

POWERLEVEL9K_CUSTOM_NEXT="echo `task +next +PENDING count` "
POWERLEVEL9K_CUSTOM_NEXT_BACKGROUND="yellow4"
POWERLEVEL9K_CUSTOM_NEXT_FOREGROUND="black"


HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

plugins=(colored-man dirhistory sudo zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
alias ls='ls --color -h --group-directories-first'
alias fless='less $(fzf)'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
