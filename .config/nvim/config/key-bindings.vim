
" F3 - go back to previous buffer
" F4 - select a buffer
nnoremap <F3> :b#<CR>
nnoremap <F4> :buffers<CR>:buffer<Space>

" F5 Open NERDTree
" F6 move to next buffer
nnoremap <F5> :NERDTree<CR>
nnoremap <F6> :NERDTreeClose<CR>

" F7/F8 jump to prev/next error
nnoremap <F7> :cprevious<CR>
nnoremap <F8> :cnext<CR>

" Ctrl-d Copy word under cursor
" Ctrl-f Paste word in buffer instead of word under cursor
nnoremap <C-s> <ESC>yiw
inoremap <C-s> <ESC>yiw
nnoremap <C-d> <ESC>ciw<C-r>0<ESC>

" Ctrl-a to prev tag
" Ctrl-s to next tag
nnoremap <\-n> <ESC>:tnext<CR>
nnoremap <\-b> <ESC>:tprev<CR>

" Ctrl-f FZF files search
" Ctrl-b FZF buffer search
nnoremap <C-f> <ESC>:FZF<CR>
nnoremap <C-b> <ESC>:Buffers<CR>

nnoremap <C-g> <ESC>:GitGutterToggle<CR>
noremap <C-x> <ESC>:GitGutterNextHunk<CR>
noremap <C-z> <ESC>:GitGutterPrevHunk<CR>
nnoremap <C-c> <ESC>:GitGutterStageHunk<CR>
"nnoremap <C-v> <ESC>:GitGutterUndoHunk<CR>
"nmap <silent> <C-x>:call NextHunkAllBuffers()<CR>
"nmap <silent> <C-z>:call PrevHunkAllBuffers()<CR>

" create ctags and cscope tags
nnoremap <F10> <ESC>:!cscope -Rbu<CR>:cs reset<CR>
inoremap <F12> <ESC>:!ctags -R --fields=+iaS --extra=+q .<CR>

" COC mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" recondiser --------
" F2 run bash commands
nnoremap <F2> :!

" ?????
nnoremap <F9> :wincmd w<CR>
