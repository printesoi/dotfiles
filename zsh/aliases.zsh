# ls with color
alias lc='ls --color=auto'

# Opening
alias xo="xdg-open"
alias ko="kde-open"

# utilities
alias octave='octave -q'
alias irb='irb --simple-prompt'

# make
alias m='make'
alias m2='make -j2'
alias m4='make -j4'
alias mi='make && sudo make install'
alias m2i='make -j2 && sudo make install'
alias m4i='make -j4 && sudo make install'

# misc
alias tmux='tmux -2'
alias auth='vim ~/.auth.bfa'
alias -g NF='*(.om[1])' # newest file
alias -g ND='*(/om[1])' # newest directory

# System
alias kernlog='sudo journalctl _TRANSPORT=kernel'
