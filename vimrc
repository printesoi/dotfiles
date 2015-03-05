" Global "{{{
    " General "{{{
        set nocompatible
        filetype off
        set clipboard=unnamed
        set ttyfast
        set history=3000
        set backspace=2
        set gdefault
        set autowriteall
        set number
        set mouse=a
        set nobackup
        set noswapfile
        set virtualedit=block
        set keywordprg=man
        set hidden
        set encoding=utf-8
        set colorcolumn=80
        set textwidth=79        " wrap the text
        set nowrap
        " Hide the default mode text (e.g. -- INSERT -- below the statusline)
        set noshowmode

        " Remap the <Leader> key
        let mapleader=","

        " Disable for now Sunset
        let g:loaded_sunset = 1

        " Set Vundle
        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()

        " Vundle Bundles
        Plugin 'gmarik/vundle'
        Plugin 'YankRing.vim'
        Plugin 'a.vim'
        Plugin 'mileszs/ack.vim'
        "Plugin 'rosenfeld/conque-term'
        Plugin 'Cpp11-Syntax-Support'
        Plugin 'kien/ctrlp.vim'
        Plugin 'endel/ctrlp-filetype.vim'
        Plugin 'printesoi/nerdcommenter'
        "Plugin 'scrooloose/nerdtree'
        Plugin 'kien/rainbow_parentheses.vim'
        Plugin 'godlygeek/tabular'
        Plugin 'majutsushi/tagbar'
        Plugin 'SirVer/ultisnips'
        Plugin 'honza/vim-snippets'
        Plugin 'bling/vim-airline'
        "Plugin 'altercation/vim-colors-solarized'
        Plugin 'printesoi/vim-colors-solarized'
        Plugin 'wincent/Command-T'
        "Plugin 'pydave/AsyncCommand'
        "Plugin 'scrooloose/syntastic'
        "Plugin 'Valloric/YouCompleteMe'
        "Plugin 'Yggdroot/indentLine'
        Plugin 'Rip-Rip/clang_complete'
        "Plugin 'tpope/vim-obsession'
        "Plugin 'gregsexton/Muon'
        Plugin 'troydm/easybuffer.vim'
        "Plugin 'endel/vim-github-colorscheme'
        "Plugin 'noahfrederick/vim-hemisu'
        "Plugin 'amdt/sunset'
        "Plugin 'nginx.vim'
        "Plugin 'duff/vim-scratch'
        "Plugin 'Shougo/vimproc.vim'
        "Plugin 'eagletmt/ghcmod-vim'
        Plugin 'pangloss/vim-javascript'
        Plugin 'nathanaelkane/vim-indent-guides'
        Plugin 'suan/vim-instant-markdown'
        Plugin 'tpope/vim-markdown'
        "Plugin 'edkolev/tmuxline.vim'
        "Plugin 'leshill/vim-json'
        Plugin 'jiangmiao/simple-javascript-indenter'
        "Plugin 'tpope/vim-vinegar.git'
        Plugin 'briancollins/vim-jst'
        Plugin 'vim-ruby/vim-ruby'
        Plugin 'groenewege/vim-less'
        Plugin 'printesoi/gruvbox'

        " Load the Man function "{{{
        let $PAGER=""
        "}}}
        runtime! ftplugin/man.vim
        " Editor options "{{{
            set guicursor=a:blinkon0
            set lazyredraw           " do not redraw while running macros
        " }}}
        " Search options "{{{
            set incsearch
            set hlsearch
            nohlsearch
        " }}}
        " No bell or flash "{{{
            set noerrorbells
            set novisualbell
            set t_vb=
        " }}}
        " Folding "{{{
            "set foldenable
            "set foldmethod=syntax
        " }}}
    " }}}
    " Pathogen "{{{
        "call pathogen#infect()
    " }}}
    " Text, tab and indent related "{{{
        set cindent
        set autoindent
        set expandtab
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set list
        " There's some problems with unicode characters for `tab`: →,»,▸
        set listchars=tab:\|\ ,trail:·,precedes:«,extends:»
        set sidescroll=5
    " }}}
    " Interface "{{{
        syntax on
        syntax enable
        set t_Co=256        " tell vim that terminal has 256 colors

        set bg=dark
        color gruvbox

        if has("gui_running")
            " GUI is running or is about to start.
            " Maximize gvim window.
            set lines=999 columns=999
        endif
    " }}}
    " Wildmenu and statusline "{{{
        set modeline
        set statusline=%<%f\ %y%h%m%r%=%-24.(0x%02B,%l/%L,%c%V%)\ %P
        set laststatus=2
        set wildmenu
        set wildignore+=*.o,*.obj,.git,*.class,*.out,*.exe,*.png,*.jpg,*.hi
    " }}}

    " Functions "{{{
        " Show the stack of syntax items where the cursor is located
        function! <SID>SynStack()
            if !exists("*synstack")
                return
            endif
            echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
        endfunc

        nmap <C-M-R> :call <SID>reloadAll()<CR>
        function! <SID>reloadAll()
            :bufdo if filereadable(expand('%')) | e! | else | bw | endif
        endfunc

        " Add or substract one from the first number forward or backward in the
        " entire file
        function! AddSubtract(char, back)
            let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
            call search(pattern, 'cw' . a:back)
            execute 'normal! ' . v:count1 . a:char
            silent! call repeat#set(":\<C-u>call AddSubtract('" .a:char. "', '" .a:back. "')\<CR>")
        endfunction

        function! Git_Repo_Cdup() " Get the relative path to repo root
            "Ask git for the root of the git repo (as a relative '../../' path)
            let git_top = system('git rev-parse --show-cdup')
            let git_fail = 'fatal: Not a git repository'
            if strpart(git_top, 0, strlen(git_fail)) == git_fail
                " Above line says we are not in git repo. Ugly. Better version?
                return ''
            else
                " Return the cdup path to the root. If already in root,
                " path will be empty, so add './'
                return './' . git_top
            endif
        endfunction

        function! CD_Git_Root()
            execute 'cd '.Git_Repo_Cdup()
            let curdir = getcwd()
            echo 'CWD now set to: '.curdir
        endfunction

        " Define the wildignore from gitignore. Primarily for CommandT
        function! WildignoreFromGitignore()
            " silent call CD_Git_Root()
            let gitignore = '.gitignore'
            if filereadable(gitignore)
                let igstring = ''
                for oline in readfile(gitignore)
                    let line = substitute(oline, '\s|\n|\r', '', "g")
                    if line =~ '^#' | con | endif
                    if line == '' | con  | endif
                    if line =~ '^!' | con  | endif
                    if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
                    let igstring .= "," . line
                endfor
                let execstring = "set wildignore+=".substitute(igstring,'^,','',"g")
                execute execstring
                echo 'Wildignore defined from gitignore in: '.getcwd()
            else
                echo 'Unable to find gitignore'
            endif
        endfunction
    " }}}

    " Keymappings "{{{
        inoremap jj <ESC>
        nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>
        noremap <F3> <Esc>:set nonumber!<CR>
        inoremap <F3> <Esc>:set nonumber!<CR>
        noremap <F4> <ESC>:NERDTreeToggle<CR>
        nmap <F8> :TagbarToggle<CR>
        imap <F8> <ESC>:TagbarToggle<CR>

        " Jump between windows
        noremap <C-J> <ESC><C-W>j
        inoremap <C-J>  <ESC><C-W>j
        noremap <C-K> <ESC><C-W>k
        inoremap <C-K> <ESC><C-W>k
        noremap <C-H> <ESC><C-W>h
        inoremap <C-H> <ESC><C-W>h
        noremap <C-L> <ESC><C-W>l
        inoremap <C-L> <ESC><C-W>l

        " Normal copy / paste behavior
        noremap <C-Q> <ESC>:qa<CR>
        inoremap <C-Q> <ESC>:qa<CR>
        noremap <C-S> <ESC>:w<CR>
        inoremap <C-S> <ESC>:w<CR>
        noremap <C-V> <ESC>"+gP
        inoremap <C-V> <ESC>"+gP
        vnoremap <C-C> "+y

        inoremap <C-B> <C-V>
        vnoremap <C-B> <C-V>
        noremap <C-B> <C-V>

        " Editing and reloading config file
        map <Leader>sg :source $MYGVIMRC<CR>
        map <Leader>sv :source $MYVIMRC<CR>
        map <Leader>g :e $MYGVIMRC<CR>
        map <Leader>v :e $MYVIMRC<CR>

        " Open Quickfix window
        map <Leader>qf <ESC>:copen<CR>
        imap <Leader>qf <ESC>:copen<CR>
        vmap <Leader>qf <ESC>:copen<CR>
        nmap <Leader>qf <ESC>:copen<CR>

        " Close Quickfix window
        map <Leader>qc <ESC>:cclose<CR>
        imap <Leader>qc <ESC>:cclose<CR>
        vmap <Leader>qc <ESC>:cclose<CR>
        nmap <Leader>qc <ESC>:cclose<CR>

        " Open Location list
        map <Leader>lf <ESC>:lopen<CR>
        imap <Leader>lf <ESC>:lopen<CR>
        vmap <Leader>lf <ESC>:lopen<CR>
        nmap <Leader>lf <ESC>:lopen<CR>

        " Close Location list
        map <Leader>lc <ESC>:lclose<CR>
        imap <Leader>lc <ESC>:lclose<CR>
        vmap <Leader>lc <ESC>:lclose<CR>
        nmap <Leader>lc <ESC>:lclose<CR>


        map <Leader><F8> <ESC>:silent AsyncCommand clementine -t<CR><CR>

        " Disable arrows
        map j gj
        map k gk
        nmap <up> <nop>
        nmap <down> <nop>
        nmap <left> <nop>
        nmap <right> <nop>
        vmap <up> <nop>
        vmap <down> <nop>
        vmap <left> <nop>
        vmap <right> <nop>

        " if you forgot to open a file with sudo
        cmap w!! w !sudo tee % >/dev/null
        "map <Leader><tab> :Scratch<CR>
        map <Leader>S :Scratch<CR>

        " Shortcuts to add or the substract forward and backward
        nnoremap <silent>         <C-a> :<C-u>call AddSubtract("\<C-a>", '')<CR>
        nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
        nnoremap <silent>         <C-x> :<C-u>call AddSubtract("\<C-x>", '')<CR>
        nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>

        " Show EasyBuffer
        map <Leader>eb  <ESC>:EasyBuffer<CR>
        vmap <Leader>eb  <ESC>:EasyBuffer<CR>
        imap <Leader>eb  <ESC>:EasyBuffer<CR>

        " Jump to the next buffer using Ctrl + Tab
        "map <C-Tab>   <ESC>:bnext<CR>
        "vmap <C-Tab>   <ESC>:bnext<CR>
        "imap <C-Tab>   <ESC>:bnext<CR>
        map <Leader><Tab>   <ESC>:bnext<CR>
        vmap <Leader><Tab>   <ESC>:bnext<CR>
        imap <Leader><Tab>   <ESC>:bnext<CR>

        " Jump to the previous buffer using Ctrl + Shift + Tab
        "map <C-S-Tab>   <ESC>:bprevious<CR>
        "vmap <C-S-Tab>   <ESC>:bprevious<CR>
        map <Leader><S-Tab>   <ESC>:bprevious<CR>
        vmap <Leader><S-Tab>   <ESC>:bprevious<CR>
        imap <Leader><S-Tab>   <ESC>:bprevious<CR>

        " Display syntax stack
        nmap <C-S-z> :call <SID>SynStack()<CR>

        nnoremap <LEADER>gr :call CD_Git_Root()<cr>
        nnoremap <LEADER>cti :call WildignoreFromGitignore()<cr>
        nnoremap <LEADER>cwi :set wildignore=''<cr>:echo 'Wildignore cleared'<cr>
    " }}}

    " Filetype options "{{{
        filetype on
        filetype plugin on
        filetype indent on
        filetype plugin indent on

        " Filetype tweaks
        autocmd FileType java       setlocal tw=78 cin wrap foldmethod=marker
        autocmd FileType c,cpp      setlocal cindent noexpandtab shiftwidth=8 tabstop=8 formatoptions+=l cinoptions=(0,W4
        autocmd FileType gitconfig  setlocal shiftwidth=4 tabstop=4 noexpandtab
        autocmd FileType python     setlocal autoindent expandtab sts=4 sw=4
        autocmd FileType haskell    setlocal tw=72 sw=2 sts=2 et
        autocmd FileType tex        setlocal tw=72 sw=2 sts=2 ai
        "autocmd FileType tex        so ~/.vim/abbrevs.vim
        autocmd FileType php        setlocal tw=72 shiftwidth=4 tabstop=4 cindent noexpandtab fo=croql
        autocmd FileType ruby       setlocal tw=72 cindent shiftwidth=2 tabstop=2 keywordprg=ri
        autocmd FileType html       setlocal shiftwidth=4 tabstop=4
        autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 shiftround expandtab
        autocmd BufNewFile,BufReadPost *.md set filetype=markdown
        autocmd BufRead,BufNewFile *.wiki   setlocal ft=creole
        autocmd BufRead,BufNewFile *.tex    setlocal ft=tex
        autocmd BufRead,BufNewFile *.cool   setlocal ft=cool
        autocmd BufRead,BufNewFile *.cl     setlocal ft=cool
        autocmd BufRead,BufNewFile *.miC    setlocal ft=C
        autocmd BufRead,BufNewFile *.g      setlocal ft=antlr
        autocmd BufRead,BufNewFile *.clp    setlocal ft=clips

        autocmd BufRead,BufNewFile *.bb     setlocal ft=conf
        autocmd BufRead,BufNewFile *.bbappend     setlocal ft=conf

        autocmd BufNewFile,BufRead /home/victor/dev/cltaxis/trunk/cltaxis/* set tabstop=4 shiftwidth=4 expandtab

        " for latex
        set grepprg=grep\ -nH\ $*
        let g:tex_flavor='latex'

        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,longest
    " }}}

    " Plugins options "{{{
        " MinibufExplorer {{{
            let g:miniBufExplMapWindowNavVim = 1
            let g:miniBufExplMapWindowNavArrows = 1
            let g:miniBufExplMapCTabSwitchBufs = 1
            let g:miniBufExplModSelTarget = 1
        " }}}

        " Command-T Configuration "{{{
            let g:CommandTScanDotDirectories = 1
            let g:CommandTMaxHeight = 20
            let g:CommandTTraverseSCM = 'none'
            cmap F5 CommandTFlush
        " }}}

        " Ack plugin "{{{
            let g:ackprg="ack -H --nocolor --nogroup --column"
            command -nargs=* AckCSrc :Ack --type=cc -i <args>
        " }}}

        " EasyMotion "{{{
            let g:EasyMotion_leader_key = '<Leader><Leader>'
        " }}}

        " Yankring "{{{
            let g:yankring_history_file = ".vim/tmp/yankring_history"
            let g:yankring_enabled = 0
        " }}}

        " ConqueTerm "{{{
            let g:ConqueTerm_FastMode = 1
            let g:ConqueTerm_InserOnEnter = 1
            let g:ConqueTerm_TERM = 'xterm'
        " }}}

        " Haskell indent "{{{
            let g:haskell_indent_if = 2
            let g:haskell_indent_case = 2
        " }}}

        " Clang-complete options "{{{
            let g:clang_hl_error = 1
            "let g:clang_auto_select = 2
            let g:clang_complete_copen = 1
            let g:clang_use_library = 1
            let g:clang_snippets = 1
            let g:clang_snippets_engine = 'clang_complete'
            let g:clang_trailing_placeholder = 1
            let g:clang_conceal_snippets = 1
            let g:clang_complete_macros = 1
            let g:clang_complete_patterns = 1
            let g:clang_complete_copen = 1
        " }}}

        " ControlP "{{{
            let g:ctrlp_default_input = 1
            let g:ctrlp_cmd='CtrlPMixed'

            " CTRLP for filetype
            let g:ctrlp_extensions = ['filetype']
            silent! nnoremap <unique> <silent> <Leader>f :CtrlPFiletype<CR>
            silent! nnoremap <unique> <silent> <Leader>r :CtrlPMRUFiles<CR>
        " }}}

        " Vim-powerline settings "{{{
            "let g:Powerline_colorscheme="skwp"
            if $TERM == "rxvt-unicode-256color"
                let g:Powerline_symbols='unicode'
            else
                let g:Powerline_symbols='fancy'
            end
        " }}}

        " vim-airline "{{{
            let g:airline_powerline_fonts = 1
            let g:airline_theme = 'gruvbox'
            let g:airline#extensions#tabline#enabled = 1
            let g:airline#extensions#tagbar#enabled = 1
            let g:airline#extensions#tagbar#flags = ''
            let g:airline#extensions#whitespace#mixed_indent_algo = 1
        " }}}

        " vim-gitgutter "{{{
           let g:gitgutter_realtime = 0
           let g:gitgutter_eager = 0
        " }}}

        " Tagbar "{{{
            let g:tagbar_autoclose = 0  " autoclose the window when selecting a tag
        " }}}
        "
        " Solarized "{{{
            let g:solarized_termcolors=256
            let g:solarized_menu=0
        "}}}
        "
        " Molokai "{{{
            let g:molokai_original=1
        "}}}

        " YCM "{{{
            let g:ycm_global_ycm_extra_conf = '/home/printesoi/dotfiles/vimfiles/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
        "}}}

        " UltiSnips "{{{
            let g:UltiSnipsExpandTrigger="<tab>"
            let g:UltiSnipsJumpForwardTrigger="<tab>"
            let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
        " }}}

        " Syntastic "{{{
            let g:syntastic_c_compiler = 'clang'
            let g:syntastic_c_compiler_options = '-Wall -Wno-implicit-function-declaration'
            let g:syntastic_c_check_header = 1
            let g:syntastic_c_no_include_search = 1
            let g:syntastic_c_no_default_include_dirs = 1
            let g:syntastic_c_auto_refresh_includes = 1
            let g:syntastic_ignore_files = ['^/usr/include/']
            let g:syntastic_c_config_file = '.syntastic_c_config'
            let g:syntastic_c_remove_include_errors = 1
        "}}}

        " IndentLine "{{{
            let g:indentLine_char = '┆'
            let g:indentLine_faster = 0
        " }}}

        " Sunset "{{{
            let g:sunset_latitude = 44.4355
            let g:sunset_longitude = 26.1025
            let g:sunset_utc_offset = 3
        " }}}

        " Instant markdown "{{{
            let g:instant_markdown_slow = 1
        " }}}

        " Simple Javascript Indenter "{{{
            let g:SimpleJsIndenter_BriefMode = 1
        " }}}

        " Indent Guides "{{{
            let g:indent_guides_guide_size = 1
            let g:indent_guides_start_level = 2
        " }}}

    " }}}

    " CScope "{{{
        if has("cscope")
            " Look for a 'cscope.out' file starting from the current directory,
            " going up to the root directory.
            let s:dirs = split(getcwd(), "/")
            while s:dirs != []
                let s:path = "/" . join(s:dirs, "/")
                if (filereadable(s:path . "/cscope.out"))
                    execute "cs add " . s:path . "/cscope.out " . s:path . " -v"
                    break
                endif
                let s:dirs = s:dirs[:-2]
            endwhile

            set csto=0  " Use cscope first, then ctags
            set cst     " Only search cscope
            set csverb  " Make cs verbose

            nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
            nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
            nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
            nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

            " Open a quickfix window for the following queries.
            set cscopequickfix=s-,c-,d-,i-,t-,e-,g-
        endif
    " }}}

" }}}
