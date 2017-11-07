# BASH PROFILE | BEGIN


# COLORS | BEGIN
BOLD="\[\033[1m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[34m\]"
PURPLE="\[\033[0;35m\]"
OFF="\[\033[m\]"

HOST="\h"
USER="\u"
DIR="\w"
NEWLINE="\n"
DATE="\d"
TIME="\t"
# COLORS | END


# PARSE TO PROMPT METHODS | BEGIN

# GIT BRANCH IN PROMPT | BEGIN
function is_git_repository {
  git branch > /dev/null 2>&1
}
function set_git_branch {
  BRANCH=`(parse_git_branch)`
}
function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
# GIT BRANCH IN PROMPT | END

# VIRTUALENV IN PROMPT | BEGIN
function set_virtualenv () {
   if test -z "$VIRTUAL_ENV" ; then
       PYTHON_VIRTUALENV=""
   else
       PYTHON_VIRTUALENV="(${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE})"
   fi
 }
# ACTIVATE VIRTUALENV IN PROMPT | END

# PARSE TO PROMPT METHODS | END

# METHOD TO SET PROMPT | BEGIN
function set_bash_prompt {

    EXITSTATUS="$?"

    #SET PYTHON_VIRTUALENV VARIABLE
    set_virtualenv

    # SET GIT BRANCH VARIABLE
   if is_git_repository ; then
     set_git_branch
   else
     BRANCH=''
   fi

    PROMPT="\[\033]0;C@${HOST}: \w\007\n${RED}${TIME} ${DATE} [C@${HOST}]:[${BLUE}\w${RED}]"

    if [ "${EXITSTATUS}" -eq 0 ]
    then
        PS1="${PROMPT} [${GREEN}${EXITSTATUS}${RED}]${OFF} ${PYTHON_VIRTUALENV} ${BRANCH}\n$ "
    else
        PS1="${PROMPT} [${BOLD}${EXITSTATUS}${RED}]${OFF} ${PYTHON_VIRTUALENV} ${BRANCH}\n$ "
    fi

    PS2="${BOLD}>${OFF} "
}
PROMPT_COMMAND=set_bash_prompt
# METHOD TO SET PROMPT | END


# ALIASES | BEGIN

# GIT ALIASES | BEGIN
alias gc="git commit -m"
alias gp="git pull"
alias gs="git status"
alias gitp="git push"
alias ga="git add ."
alias gA="git add -A"
# GIT ALIASES | END

# DIRECTORY NAVIGATION | BEGIN
alias gtfg="cd $HOME/Programming/fg"
alias gtfga="cd $HOME/Programming/fg/src/angular_frontend"
# DIRECTORY NAVIGATION | END

# LIST DIRECTORIES | BEGIN
alias ls="ls -FG"
alias ll="ls -lFGh"
alias la="ls -alFGh"
# LIST DIRECTORIES | END

# PYTHON | BEGIN
alias python2="python"
alias python="python3"
# PYTHON | END

# PIP | BEGIN
alias pip2="pip"
alias pip="pip3"
# PIP | END

# DJANGO ALIASES | BEGIN
alias mig="python manage.py migrate"
alias makemig="python manage.py makemigrations"
alias serve="python manage.py runserver"
# DJANGO ALIASES | END

#ANACONDA | BEGIN
alias defcondaa="$HOME/anaconda/bin/activate"
alias defcondad="$HOME/anaconda/bin/deactivate"
#ANACONDA | END

#VIRTUALENVIRONMENT | BEGIN
alias venv="virtualenv -p python3 $HOME/Programming/Virtual_Environments/"
alias venv2="virtualenv $HOME/Programming/Virtual_Environments/"
#VIRTUALENVIRONMENT | END


#ALIASES | END



# BASH PROFILE | END
