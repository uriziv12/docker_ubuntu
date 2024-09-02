function git_branch_PS1() {  # If git repo - print decoreated branch name to be added as PS1
  git rev-parse --is-inside-git-repository >/dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo -e "\033[31m$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\033[0m:"
  fi
}

PS1='\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;31m\]$(git_branch_PS1)\[\033[00m\]\[\033[01;34m\]\W\[\033[00m\]> '

export REPOS=~/repos

alias ll='ls -alF --color'
alias repos='cd $REPOS'
alias gs='git status'
alias gl='git lg'
alias gg='git grep -n --color'
