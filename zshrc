# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export HOME=/home/$USER
export ZSH=$HOME/.oh-my-zsh
export TERM=xterm-256color		# show more color

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
ENABLE_CORRECTION="false"

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
plugins=(git zsh-autosuggestions command-not-found)

ZSH_THEME=lty			# i define it by myself
source $ZSH/oh-my-zsh.sh

# User configuration

if [[ -n MANPATH ]]; then
	export MANPATH="/usr/local/man:$MANPATH"
else
	export MANPATH="/usr/local/man"
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"


# alias {{
alias ls='ls -F --color=auto'
alias l=ls
alias ll="ls -al"
alias la='ls -a'
alias l.='ls -d .*'
alias v=vim
alias vi=vim
alias emacs="emacs -nw"		# cli
alias mv='mv -i'
alias rm='rm -i'
alias grep='grep --color=auto'
alias tmux='tmux -2'
alias pingbaidu='ping www.baidu.com'
alias pinggoogle='ping www.google.com'
alias mount='mount -o uid=1000'
alias psall='ps xao pid,ppid,pgid,sid,command'
alias valgrind='valgrind --leak-check=full --show-leak-kinds=all'
# }}


#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      

#启用自动 cd，输入目录名回车进入目录
setopt AUTO_CD


#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word

#use emacs mode
setopt emacs

setopt NO_BEEP

#自动补全功能 {{
setopt AUTO_LIST
setopt AUTO_MENU
unsetopt correct_all
# }}

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


##空行(光标在行首)补全 "cd " {{
function user-complete(){
	case $BUFFER in
	"" )                       # 空行填入 "cd "
	BUFFER="cd "
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
# }}


autoload run-help

# 路径别名 {{
hash -d E="/etc/"
hash -d C="$HOME/CLanguage"
hash -d CPP="$HOME/C++"
hash -d L="$HOME/lisp"
hash -d P="$HOME/python"
hash -d H="$HOME/html"
hash -d S="$HOME/shell"
hash -d G="$HOME/go"
hash -d JS="$HOME/javascript"
hash -d J="$HOME/jvm"
# }}


# 补全ping {{
zstyle ':completion:*:ping:*' hosts www.google.com {www.,}szu.edu.cn www.baidu.com
# }}



# 高亮命令 {{
setopt extended_glob
TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

function recolor-cmd() {
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
function check-cmd-self-insert() { zle .self-insert && recolor-cmd }
function check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char
# }}

# history {{
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
# }}


# 在命令前插入sudo {{
function sudo-command-line() {
	[[ -z $BUFFER  ]] && zle up-history
	[[ $BUFFER != sudo\ *  ]] && BUFFER="sudo $BUFFER"
	zle end-of-line #光标移动到行末
}
zle -N sudo-command-line		# new zsh widget
bindkey "\e\e" sudo-command-line	# shortcut ESC ESC
# }}

# Path {{
# anaconda
if [[ $PATH != *$HOME/anaconda3/bin* ]]; then
	export PATH="$HOME/anaconda3/bin:$PATH"
fi
export PYTHONPATH=$PYTHONPATH:$HOME/anaconda3/lib/python3.6/site-packages

# golang
if [[ $PATH != */use/local/go/bin* ]]; then
	export PATH="$PATH:/usr/local/go/bin"
fi
export PATH="$PATH:$HOME/go/bin"
export GOPATH="$HOME/go"

# cuda
export PATH=/usr/local/cuda-8.0/bin:$PATH
if [[ -n $LD_LIBRARY_PATH ]]; then
	export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
else
	export LD_LIBRARY_PATH=/usr/local/cuda/lib64
fi

# local
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
# }}

# spark
export PYSPARK_DRIVER_PYTHON=ipython
export SPARK_HOME=/usr/local/spark

# java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# rust
export PATH="$HOME/.cargo/bin:$PATH"

source $HOME/.primary.sh		# some primary environment variable
