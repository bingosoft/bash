export BASH_SILENCE_DEPRECATION_WARNING=1
alias ll='ls -lAG'
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

export PS1=" \[\033[34m\]\u@\h \[\033[33m\]\w\[\033[31m\]\[\033[00m\] \[\033[32m\]\$(parse_git_branch)\[\e[00m\]$ "
