" Vim color file
" Maintainer:   Your name <youremail@something.com>
" Last Change:  
" URL:		

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=light "dark or light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="KDE"

hi Normal guifg=Black guibg=#FFFFFF gui=NONE

" OR

" highlight clear Normal
" set background&
" highlight clear
" if &background == "light"
"   highlight Error ...
"   ...
" else
"   highlight Error ...
"   ...
" endif

" A good way to see what your colorscheme does is to follow this procedure:
" :w 
" :so % 
"
" Then to see what the current setting is use the highlight command.  
" For example,
" 	:hi Cursor
" gives
"	Cursor         xxx guifg=bg guibg=fg 
 	
" Uncomment and complete the commands you want to change from the default.

"hi Cursor		
hi CursorLine guifg=White guibg=#86aed5 gui=NONE
"hi CursorIM	
"hi Directory	
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
"hi ErrorMsg	
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
"hi IncSearch	
hi LineNr guifg=#2d2d2d guibg=#b3b3b3 gui=bold
"hi ModeMsg		
"hi MoreMsg		
"hi NonText		
"hi Question	
"hi Search		
"hi SpecialKey	
hi StatusLine guibg=#e3e3e3
hi StatusLineNC guibg=#e3e3e3
hi PMenuSel guibg=#e3e3e3
"hi Title	  
"hi Visual		
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
hi Comment guifg=#777777 guibg=NONE gui=BOLD
hi Constant guifg=#557799 guibg=NONE gui=NONE
hi String guifg=#BB4444 guibg=NONE gui=bold
"hi Identifier	
"hi Statement	
"hi PreProc	
"hi Type		
"hi Special	
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		

" Vim syntax

hi cInclude guifg=#557799 gui=bold
hi cDefine guifg=#557799 gui=bold
hi cPreCondit guifg=#557799 gui=bold
hi cConstant guifg=#557799 gui=bold
hi cNumber guifg=#0000DD gui=NONE
hi cIncluded guifg=#BB4444 gui=bold
hi cType guifg=#008800 guibg=NONE gui=BOLD
hi cppType guifg=#008800 guibg=NONE gui=BOLD
hi cStructure guifg=#008800 guibg=NONE gui=BOLD
hi cppStructure guifg=#008800 guibg=NONE gui=BOLD
hi cppStatement guifg=#008800 guibg=NONE gui=BOLD
hi cStatement guifg=#008800 guibg=NONE gui=BOLD
hi cString guifg=#BB4444 gui=bold
hi cRepeat guifg=#008800 guibg=NONE gui=BOLD
hi cppBoolean guifg=#006699 guibg=NONE gui=BOLD

