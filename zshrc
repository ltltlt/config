# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export HOME=/home/ty-l8
export ZSH=$HOME/.oh-my-zsh

# path for python

#if $PYTHONPATH ; then
	#PYTHONPATH=$PYTHONPATH:'$HOME/python/mymodule'
#else
	#PYTHONPATH='$HOME/python/mymodule'
#fi
#export PYTHONPATH

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"
DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR 'vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='ls -F --color=auto'
alias ll="ls -al"
alias l="ls"
alias la='ls -a'
alias l.='ls -d .*'
alias vi="vim"
alias emacs="emacs -nw"
alias cp='cp'
alias mv='mv'
alias rm='rm'
alias grep='grep --color=auto'
alias y='yaourt'
alias dict=ydcv
alias tarn='tar jxvf'
alias tarc='tar jcvf'
alias tmux='tmux -2'
alias lock='xscreensaver-command -lock'
alias pingbaidu='ping www.baidu.com'
alias pinggoogle='ping www.google.com'
alias pingszu='ping www.szu.edu.cn'
alias mount='mount -o uid=1000'



#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      

#启用自动 cd，输入目录名回车进入目录
setopt AUTO_CD


#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

#use vim mode
setopt VI

setopt NO_BEEP

#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
unsetopt correct_all

#自动补全选项
#zstyle ':completion:*' verbose yes
#zstyle ':completion:*' menu select
#zstyle ':completion:*:*:default' force-list always
#zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

#zstyle ':completion:*:match:*' original only
#zstyle ':completion::prefix-1:*' completer _complete
#zstyle ':completion:predict:*' completer _complete
#zstyle ':completion:incremental:*' completer _complete _correct
#zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
 
#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'
 
#彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
 
#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric


#kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'


##空行(光标在行首)补全 "cd " {{{
user-complete(){
case $BUFFER in
"" )                       # 空行填入 "cd "
BUFFER="cd "
zle end-of-line
zle expand-or-complete
;;
"cd --" )                  # "cd --" 替换为 "cd +"
BUFFER="cd +"
zle end-of-line
zle expand-or-complete
;;
"cd +-" )                  # "cd +-" 替换为 "cd -"
BUFFER="cd -"
zle end-of-line
zle expand-or-complete
;;
* )
zle expand-or-complete
;;
esac
}
zle -N user-complete
bindkey "\t" user-complete


#[Esc][h] man 当前命令时，显示简短说明
alias run-help >&/dev/null && unalias run-help
autoload run-help



#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
hash -d E="/etc/"
hash -d C="$HOME/CLanguage"
hash -d CPP="$HOME/C++"
hash -d L="$HOME/lisp"
hash -d P="$HOME/python"
hash -d PP='/usr/lib/python3.5/site-packages'
hash -d M="$HOME/mariaDB"
hash -d H="$HOME/html"
hash -d B="$HOME/bash_lty"
#}}}


#{{{自定义补全
#补全 ping
zstyle ':completion:*:ping:*' hosts 192.168.1.{1,50,51,100,101} www.google.com {www.,}szu.edu.cn



#漂亮又实用的命令高亮界面
setopt extended_glob
 TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')
 
 recolor-cmd() {
     region_highlight=()
     colorize=true
     start_pos=0
     for arg in ${(z)BUFFER}; do
         ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
         ((end_pos=$start_pos+${#arg}))
         if $colorize; then
             colorize=false
             res=$(LC_ALL=C builtin type $arg 2>/dev/null)
             case $res in
                 *'reserved word'*)   style="fg=magenta,bold";;
                 *'alias for'*)       style="fg=cyan,bold";;
                 *'shell builtin'*)   style="fg=yellow,bold";;
                 *'shell function'*)  style='fg=green,bold';;
                 *"$arg is"*)
                     [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
                 *)                   style='none,bold';;
             esac
             region_highlight+=("$start_pos $end_pos $style")
         fi
         [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
         start_pos=$end_pos
     done
 }
check-cmd-self-insert() { zle .self-insert && recolor-cmd }
 check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }
 
 zle -N self-insert check-cmd-self-insert
 zle -N backward-delete-char check-cmd-backward-delete-char



####{{{
function timeconv { date -d @$1 +"%Y-%m-%d %T" }
 
# }}}


#{{{ F1 计算器
arith-eval-echo() {
LBUFFER="${LBUFFER}echo \$(( "
RBUFFER=" ))$RBUFFER"
}
zle -N arith-eval-echo
bindkey "^[[11~" arith-eval-echo
#}}}


### {PROMPT1
#autoload colors
#colors
 
#for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
#eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
#eval $color='%{$fg[${(L)color}]%}'
#(( count = $count + 1 ))
#done
#FINISH="%{$terminfo[sgr0]%}"

###命令提示符
##RPROMPT=$(echo "$RED%D %T$FINISH")
##PROMPT=$(echo "$CYAN%n@$YELLOW%M:$GREEN%/$_YELLOW>$FINISH ")

#setopt PROMPT_SUBST     # allow funky stuff in prompt
#color="blue"
#if [ "$USER" = "root"  ]; then
	#color="red"         # root is red, user is blue
#fi;
#prompt="%{$fg[$color]%}%n%{$reset_color%}@%U%{$fg[yellow]%}%m%{$reset_color%}%u %T %B%~%b "
#RPROMPT='${vim_mode} ${vcs_info_msg_0_}'
### }PROMPT1

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="ys"
# ZSH_THEME="miloshadzic"
# ZSH_THEME="nebirhos"
 ZSH_THEME="agnoster"
# ZSH_THEME="random"


# History
# ##
HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=1024                   # big history
SAVEHIST=1024                   # big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, do not wait until shell exit 
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

bindkey '^R' history-incremental-search-backward


##在命令前插入 sudo {{{
##定义功能
sudo-command-line() {
	[[ -z $BUFFER  ]] && zle up-history
	[[ $BUFFER != sudo\ *  ]] && BUFFER="sudo $BUFFER"
	zle end-of-line #光标移动到行末
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line
##}}}


#colors: black blue cyan green magenta red white yellow
INS_color=magenta
NOR_color=black
vim_ins_mode="%{$fg_bold[$INS_color]%}[I]%{$reset_color%}"
vim_cmd_mode="%{$fg_bold[$NOR_color]%}[N]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
	vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
	zle reset-prompt
}
zle -N zle-keymap-select
function zle-line-finish {
	vim_mode=$vim_ins_mode
}
zle -N zle-line-finish


#{{{ Prompt!
function _git_time_since_commit() {
# Only proceed if there is actually a commit.
  if git log -1 > /dev/null 2>&1; then
    # Get the last commit.
    last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
    now=$(date +%s)
    seconds_since_last_commit=$((now-last_commit))

    # Totals
    minutes=$((seconds_since_last_commit / 60))
    hours=$((seconds_since_last_commit/3600))

    # Sub-hours and sub-minutes
    days=$((seconds_since_last_commit / 86400))
    sub_hours=$((hours % 24))
    sub_minutes=$((minutes % 60))

    if [ $hours -gt 24 ]; then
      commit_age="${days}d"
    elif [ $minutes -gt 60 ]; then
      commit_age="${sub_hours}h${sub_minutes}m"
    else
      commit_age="${minutes}m"
    fi

    color=$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL
    echo "$color$commit_age%{$reset_color%}"
  fi
}

#colors: black blue cyan green magenta red white yellow
host_color=cyan
time_color=blue
user_color=green
root_color=red
directory_color=blue
error_color=red
jobs_color=green

host_prompt="%{$fg[$host_color]%}%B%n%b%{$reset_color%}"
#host_prompt="%{$fg_bold[$host_color]%}‹ƭƴ-ĺ6›%{$reset_color%}"

jobs_prompt1="%{$fg[$jobs_color]%}(%{$reset_color%}"

jobs_prompt2="%{$fg[$jobs_color]%}%jj%{$reset_color%}"

jobs_prompt3="%{$fg[$jobs_color]%})%{$reset_color%}"

jobs_total="%(1j.${jobs_prompt2} .)"

time_prompt1="%{$fg_bold[$time_color]%}‹%{$reset_color%}"

time_prompt2="%{$fg[$time_color]%}%D %T%{$reset_color%}"

time_prompt3="%{$fg_bold[$time_color]%}›%{$reset_color%}"

time_total="${time_prompt1}${time_prompt2}${time_prompt3}"

error_prompt1="%{$fg_bold[$error_color]%}%{$reset_color%}"

error_prompt2="%{$fg[$error_color]%}%B%?%u%{$reset_color%}"

error_prompt3="%{$fg_bold[$error_color]%}%{$reset_color%}"

error_total="%(?..${error_prompt1}${error_prompt2}${error_prompt3} )"
	
case "$TERM" in
  (screen)
	function precmd() { print -Pn "\033]0;S $TTY:t{%100<...<%4~%<<}\007" }
  ;;
  (xterm)
	directory_prompt=""
  ;;
  (*)
	directory_prompt="%{$fg[$directory_color]%}%B%3~%b%{$reset_color%}"
  ;;
esac

if [[ $USER == root ]]; then
	post_prompt="%{$fg_bold[$root_color]%}%#%{$reset_color%}"
else
	post_prompt="%{$fg_bold[$user_color]%}❯%{$reset_color%}"
fi

### PROMPT}
#ĺƭƴ
#ƶʠľ
#ƫ Ƭ ƭ Ʈ Ư ư Ʊ Ʋ Ƴ ƴ Ƶ ƶ
#ŷ Ÿ Ź ź Ż ż Ž ž
#Ĺ ĺ Ļ ļ Ľ ľ Ŀ
#Λ Ξ Ο Π Σ Φ Ψ Ω Ϊ Ϋ ά έ ή ί ΰ α β γ δ ε ζ η θ ι κ λ μ ν ξ ο π ρ ς σ τ υ φ χ ψ ω ϊ ϋ ό ύ ώ Ϗ ϐ ϑ ϒ ϓ ϔ ϕ ϖ ϗ Ϙ ϙ Ϛ ϛ Ϝ ϝ Ϟ ϟ Ϡ ϡ Ϣ ϣ Ϥ ϥ Ϧ ϧ
#ϯ

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[red]%}✗%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[white]%}"


#PS1="${host_prompt} ${jobs_total}${time_total} ${error_total}${directory_prompt}${post_prompt} "
#PROMPT="${host_prompt} ${jobs_total}${error_total}${directory_prompt}${post_prompt} "

PROMPT='${directory_prompt} $(git_prompt_info)$(git_prompt_status) ${post_prompt} '
RPROMPT='${error_total}${jobs_total}${vim_mode}'
