autocmd bufnewfile \(m\|M\|GNUm\)akefile so /home/printesoi/.vim/make_header.txt
autocmd bufnewfile \(m\|M\|GNUm\)akefile exe "%s/Filename:.*/Filename: " . expand("%") . "/g"
autocmd bufnewfile \(m\|M\|GNUm\)akefile exe "%s/Created:.*/Created: " . strftime("%d-%m-%Y")  . "/g"
autocmd bufnewfile \(m\|M\|GNUm\)akefile exe "%s/Description:.*/Description: /g"

if has("gui_running")
	autocmd bufnewfile \(m\|M\|GNUm\)akefile exe "%s/Editor:.*/Editor: GViM 7.3/g"
endif

autocmd Bufwritepre,filewritepre \(m\|M\|GNUm\)akefile execute  "normal ma"
autocmd Bufwritepre,filewritepre \(m\|M\|GNUm\)akefile execute  "normal `a"

