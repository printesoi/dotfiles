. /etc/profile

# Source all aliases
if [ -f ~/.bash_aliases ];then
  . ~/.bash_aliases;
fi

if [ -f ~/bin/functions.sh ];then
	. ~/bin/functions.sh
fi

# History options
export HISTCONTROL=erasedups
export HISTFILE=~/.bash_history
export HISTSIZE=99999

# Environment variables
export TERM=xterm-256color
export EDITOR=vim
export PATH=$HOME/bin:$PATH

# Colorized output for ls
LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;30:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.xz=01;31:*.jpg=00;36:*.gif=00;36:*.bmp=00;36:*.xbm=00;36:*.xpm=00;36:*.tif=00;36:*.tga=00;36:*.png=00;36:*.jpeg=00;36:*.tiff=00;36:*.xcf=00;36:*.xcf.gz=00;36:*.blend=00;36:*.pcx=00;36:*.ppm=00;36:*.psd=00;36:*.mp3=00;33:*.mid=00;33:*.wav=00;33:*.au=00;33:*.m3u=00;33:*.flac=00;33:*.nes=00;31:*.smc=00;31:*.fig=00;31:*.sfc=00;31:*.smc.gz=00;31:*.fig.gz=00;31:*.sfc.gz=00;31:*.mpg=00;35:*.mpeg=00;35:*.avi=00;35:*.mov=00;35:*.fli=00;35:*.flc=00;35:*.css=01;31:';
export LS_COLORS

[[ $- == *i* ]]   &&   . $HOME/bin/git-prompt.sh
