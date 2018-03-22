# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# Colors
	RESET='\e[0m'
	ORANGE='\e[38;5;202m'
	LIGHT_GREEN='\e[38;5;118m'
	YELLOW='\e[38;5;226m'
	GREEN='\e[38;5;10m'
	PEACH='\e[38;5;196m'

	set_active_venv() {
		export ACTIVE_VENV=""
		if [ "$VIRTUAL_ENV" != "" ]; then
			export ACTIVE_VENV="\[${PEACH}\](${VIRTUAL_ENV##*/})\[${RESET}\]"
		fi
	}

	source ~/.git-prompt.sh
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWUPSTREAM="auto"
	export GIT_PS1_SHOWCOLORHINTS=1
	export GIT_PS1_SHOWDIRTYSTATE=1
	export VIRTUAL_ENV_DISABLE_PROMPT=1
	PS1='__git_ps1 "${ACTIVE_VENV}\[${LIGHT_GREEN}\][\T]\[${ORANGE}\]\u\[${RESET}\]:\[${YELLOW}\]\w\[${RESET}\]" " \[${GREEN}\]\\\$\[${RESET}\] "'
	export PROMPT_COMMAND="set_active_venv; ${PS1}; $PROMPT_COMMAND"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Include Go bin into path
export PATH=$PATH:/usr/local/go/bin

# Set Go workspace
export GOPATH=$HOME/go

# Add GOPATH/bin to PATH
export PATH=$PATH:$GOPATH/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
