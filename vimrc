" Global "{{{
    " General "{{{
        set nocompatible
        set clipboard=unnamed
        "set ttyfast
        set history=3000
        set backspace=2
        set gdefault
        set autowriteall
        set number
        set mouse=a
        set nobackup
        set noswapfile
        set virtualedit=block
        set keywordprg=vman
        set hidden
        set encoding=utf-8
        set colorcolumn=80
        set textwidth=79        " wrap the text
        set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

        "set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

        " for latex
        set grepprg=grep\ -nH\ $*
        let g:tex_flavor='latex'

        " Load the Man function "{{{
        let $PAGER=""
        "}}}
        runtime! ftplugin/man.vim
        " Editor options "{{{
            set guicursor=a:blinkon0
            set lazyredraw           " do not redraw while running macros
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
        call pathogen#infect()
    " }}}
    " Text, tab and indent related "{{{
        set cindent
        set autoindent
        set expandtab
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set list
        set listchars=tab:→\ ,trail:·
        set listchars+=extends:»,precedes:«
    " }}}
    " Interface "{{{
        syntax on
        syntax enable
        set t_Co=256        " tell vim that terminal has 256 colors
        if has('gui_running')
            set bg=light
            color github
        else
            set bg=dark
            color molokai
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

    " }}}

    " Keymappings "{{{
        inoremap jj <ESC>
        nnoremap ,cd :lcd %:p:h<CR>:pwd<CR>
        noremap <F3> <Esc>:set nonumber!<CR>
        inoremap <F3> <Esc>:set nonumber!<CR>
        noremap <F2> <Esc>:TlistToggle<CR>
        inoremap <F2> <Esc>:TlistToggle<CR>
        noremap <F4> <ESC>:NERDTreeToggle<CR>

        noremap <C-Q> <ESC>:qa<CR>
        inoremap <C-Q> <ESC>:qa<CR>
        noremap <C-S> <ESC>:w<CR>
        inoremap <C-S> <ESC>:w<CR>
        noremap <C-J> <ESC><C-W>j
        inoremap <C-J>  <ESC><C-W>j
        noremap <C-K> <ESC><C-W>k
        inoremap <C-K> <ESC><C-W>k
        noremap <C-H> <ESC><C-W>h
        inoremap <C-H> <ESC><C-W>h
        noremap <C-L> <ESC><C-W>l
        inoremap <C-L> <ESC><C-W>l
        noremap <C-V> <ESC>"+gP
        inoremap <C-V> <ESC>"+gP
        vnoremap <C-C> "+y
        inoremap <C-B> <C-V>
        vnoremap <C-B> <C-V>
        noremap <C-B> <C-V>

        nmap <F8> :TagbarToggle<CR>
        imap <F8> <ESC>:TagbarToggle<CR>

        " Editing and reloading config file
        map <Leader>sg :source $MYGVIMRC<CR>
        map <Leader>sv :source $MYVIMRC<CR>
        map <Leader>g :e $MYGVIMRC<CR>
        map <Leader>v :e $MYVIMRC<CR>

        " Quickfix window
        map <Leader>qf <ESC>:copen<CR>
        imap <Leader>qf <ESC>:copen<CR>
        vmap <Leader>qf <ESC>:copen<CR>
        nmap <Leader>qf <ESC>:copen<CR>

        map <Leader>qc <ESC>:cclose<CR>
        imap <Leader>qc <ESC>:cclose<CR>
        vmap <Leader>qc <ESC>:cclose<CR>
        nmap <Leader>qc <ESC>:cclose<CR>

        " Location list
        map <Leader>lf <ESC>:lopen<CR>
        imap <Leader>lf <ESC>:lopen<CR>
        vmap <Leader>lf <ESC>:lopen<CR>
        nmap <Leader>lf <ESC>:lopen<CR>

        map <Leader>lc <ESC>:lclose<CR>
        imap <Leader>lc <ESC>:lclose<CR>
        vmap <Leader>lc <ESC>:lclose<CR>
        nmap <Leader>lc <ESC>:lclose<CR>


        map <Leader><F8> <ESC>:silent AsyncCommand clementine -t<CR><CR>

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
        map <Leader><tab> :Scratch<CR>

        " Shortcuts to add or the substract forward and backward
        nnoremap <silent>         <C-a> :<C-u>call AddSubtract("\<C-a>", '')<CR>
        nnoremap <silent> <Leader><C-a> :<C-u>call AddSubtract("\<C-a>", 'b')<CR>
        nnoremap <silent>         <C-x> :<C-u>call AddSubtract("\<C-x>", '')<CR>
        nnoremap <silent> <Leader><C-x> :<C-u>call AddSubtract("\<C-x>", 'b')<CR>

        " Edit awesome config
        map <Leader>a :e ~/.config/awesome/rc.lua<CR>
        imap <Leader>a :e ~/.config/awesome/rc.lua<CR>

        " Display syntax stack
        nmap <C-S-z> :call <SID>SynStack()<CR>

        " Exuberant ctags "{{{
            " configure tags - add additional tags here or comment out not-used ones
            "set tags+=c:\users\tzesoi\vimfiles\tags\cpp
            " build tags of your own project with Ctrl-F13
            map <S-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
            imap <S-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
            " build tags for this file only with Ctrl-F11
            map <S-F11> :!ctags --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q %<CR>
            imap <S-F11> :!ctags --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q %<CR>
        " }}}
    " }}}

    " Filetype options "{{{
        filetype on
        filetype plugin on
        filetype indent on
        filetype plugin indent on

        " Filetype tweaks
        autocmd FileType java       setlocal tw=78 cin wrap foldmethod=marker
        autocmd FileType c,cpp      setlocal cindent expandtab formatoptions+=l
        autocmd FileType gitconfig  setlocal shiftwidth=4 tabstop=4 noexpandtab
        autocmd FileType python     setlocal autoindent expandtab sts=4 sw=4
        autocmd FileType haskell    setlocal tw=72 sw=2 sts=2 et
        autocmd FileType tex        setlocal tw=72 sw=2 sts=2 ai
        "autocmd FileType tex        so ~/.vim/abbrevs.vim
        autocmd FileType php        setlocal tw=72 cindent fo=croql
        autocmd FileType ruby       setlocal tw=72 cindent shiftwidth=4 tabstop=4 keywordprg=ri
        autocmd BufRead,BufNewFile *.wiki   setlocal ft=creole
        autocmd BufRead,BufNewFile *.tex    setlocal ft=tex
        autocmd BufRead,BufNewFile *.cool   setlocal ft=cool
        autocmd BufRead,BufNewFile *.cl     setlocal ft=cool
        autocmd BufRead,BufNewFile *.miC    setlocal ft=C
        autocmd BufRead,BufNewFile *.g      setlocal ft=antlr
        autocmd BufRead,BufNewFile *.clp    setlocal ft=clips

        "" automatically open and close the popup menu / preview window
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
            let g:CommandTMaxHeight = 0
            cmap F5 CommandTFlush
        " }}}

        " Ack plugin "{{{
            let g:ackprg="ack -H --nocolor --nogroup --column"
        " }}}

        " EasyMotion "{{{
            let g:EasyMotion_leader_key = '<Leader><Leader>'
        " }}}

        " Yankring "{{{
            let g:yankring_history_file = ".vim/tmp/yankring_history"
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
            let g:clang_snippets_engine = 'ultisnips'
            let g:clang_trailing_placeholder = 1
            let g:clang_complete_macros = 1
            let g:clang_complete_patterns = 1
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
            let g:airline_theme = 'luna'
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
        "}}}
        "
        " Molokai "{{{
        let g:molokai_original=1
        "}}}
    " }}}
"}}}
"
