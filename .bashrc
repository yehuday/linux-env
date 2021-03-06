# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

set -o vi
set +o emacs

bind '"\e[1~": beginning-of-line'
bind '"\e[4~": end-of-line'

################# command history stuff ######################
# history search using pg-dn pg-up
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# sync history between shells through history file
hsync() {
  builtin history -a
  builtin history -c
  builtin history -r
}

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
color_prompt=yes

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

source ~/.git_prompt.sh

#102     PS1="$HC$FGRN${debian_chroot:+($debian_chroot)}\u@sleybo-laptop]$RS:$HC$FBLE\w$HC$FYEL \$(__git_ps1)$RS\\$ "


if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1)\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;33:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -altrF'
alias la='ls -A'
alias l='ls -CF'

# Yehuda's aliases
alias g='grep -r -n -I'
alias gw='grep -r -w'
alias word='cut -d" " -f'
alias copy='xclip -i'
alias paste='xclip -o'
alias tl='tree -L '
alias tl1='tree -L 1 '
alias tl2='tree -L 2 '
alias tl3='tree -L 3 '
alias tl4='tree -L 4 '

alias pcl='find -name "*.rej" -delete -o -name "*.orig" -delete'
alias pp1='patch -p1'

# GCC stuff
alias obd='${CROSS_COMPILE}objdump -rhaD'
alias a2l='${CROSS_COMPILE}addr2line'

# Git shortcuts 
alias gl='git log --format="%Cblue%h: %Cgreen%cd: %Creset%s" --date=short'
alias gln='git log --name-status'
alias glf='git log --format="%Cblue%h: %Cgreen%cd %C(auto)%d %s" -10 --date="format-local:%Y-%m-%d %H:%M:%S"'
alias gs='git status'
alias gsh='git show'
alias gshn='git show --name-status'
alias gc='git commit -s'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gch='git checkout'
alias gchp='git checkout -p'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gau='git add -u'
alias gap='git add -p'
alias gr='git reset'
alias grh='git reset --hard'
alias gri='git rebase -i'
alias gria='git rebase -i --autosquash'
alias gfp='git format-patch'
alias gb='git branch'
alias gba='git branch -a'
alias gry='git review -y'
alias grx='git review -x'
alias grd='git review -d'
alias gfr='gau; gcan; git review;'
alias gfa='git fetch --all'

alias gsmu='git submodule update --init --recursive'
alias gsmi='git submodule sync; git submodule update --init --recursive'
alias gsml='git submodule foreach --recursive "git log --oneline -1"'

alias vim='nvim'
alias ssh='TERM=xterm-256color ssh'

git_cf() {
	git commit --fixup=$1
}

# checkpatch
CHECKPATCH="./scripts/checkpatch.pl"
checkpatch() {
	patch=`git format-patch $1^..$1`
	${CHECKPATCH} --no-tree --max-line-length=120 ${patch}; rm -f ${patch}
}
alias chp='checkpatch HEAD'
alias chps='checkpatch $1'

kill_screen() {
	screen -X -S $1  quit
}

MINICOM='-c on'
export MINICOM

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# soft link socket file to persistent location
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;

#LS_COLORS=di=36:ln=35:so=32:pi=33:ex=32:bd=33:cd=33:su=32:sg=32:tw=36:ow=36
#export LS_COLORS

complete -C '/usr/bin/aws_completer' aws
export PATH=/home/yehuday/.pyenv/bin:$PATH
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=$PATH:/home/yehuday/.fzf/bin
