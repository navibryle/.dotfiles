if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    tmux attach || tmux >/dev/null 2>&1
fi
export ZSH="/home/ivan/.config/oh-my-zsh"


plugins=(git
    vi-mode
    autoswitch_virtualenv
    zsh-system-clipboard)

source $ZSH/oh-my-zsh.sh

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000

# vi mode
bindkey -v
export KEYTIMEOUT=1
export MANPAGER='nvim +Man!'
export MANWIDTH=999

alias xg='xgamma -gamma'
alias pm='pandoc -s -o'
alias xc='xclip -selection clipboard'
alias p3='python3'
alias gi="xprop | grep WM_CLASS"
alias pR='sudo pacman -Rcns'
alias ls='ls --color=auto'
alias n='nvim'
alias rr='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias sspend='systemctl suspend'
alias rm='rm -rf'
alias x='neofetch'
alias t='tmux attach'
# C415 ANTLR generator.
alias j11='/usr/lib/jvm/java-11-openjdk/bin/java'
alias antlr4="j11 -Xmx500M org.antlr.v4.Tool"
alias grun='j11 org.antlr.v4.gui.TestRig'

alias smr='xrandr --output HDMI-1 --auto --right-of eDP-1'
alias sml='xrandr --output HDMI-1 --auto --left-of eDP-1'

export HOSTNAME="Ivan"
export ORACLE_HOME="/opt/instantclient_21_7"
export CLASSPATH="/opt/antlr/antlr4-install/bin/antlr-4.10.1-complete.jar:$CLASSPATH"
export EDITOR=nvim

# C415 antlr install
export ANTLR_INS="/opt/antlr/antlr4-install/"

export LD_LIBRARY_PATH=/opt/instantclient_21_7:$LD_LIBRARY_PATH
# export JAVA_HOME="/usr/lib/jvm/jdk8u282-b08"
# export JRE_HOME="/usr/lib/jvm/jdk8u282-b08/jre"
export CATALINA_HOME="/opt/apache-tomcat-9.0.65"


autoload -Uz compinit
compinit
# End of lines added by compinstall
source /opt/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
 
export PATH=/home/ivan/.local/share/extension_/adapter:/opt/instantclient_21_7:/opt/cisco/anyconnect/bin:/home/ivan/.local/share/guiBuilder/bin:/home/ivan/.local/share/Tester/bin:/opt/rust-analyzer-2022-08-29/target/debug:/home/ivan/.local/share/Tester/bin:/opt/discord:/home/ivan/.local/bin:/opt/ncpamixer/build:/opt/xcwd:$PATH

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
#start the shell and each new prompt in vi normal mode
zle-line-init() { zle -K vicmd; }
zle -N zle-line-init
eval "$(starship init zsh)"
