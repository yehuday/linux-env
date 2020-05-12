
" Specify a directory for plugins
call plug#begin('~/.nvim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'

" Git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tveskag/nvim-blame-line'

" Syntax highlighting
Plug 'vim-scripts/c.vim'
Plug 'vim-syntastic/syntastic'
Plug 'octol/vim-cpp-enhanced-highlight'

" Auto completion
Plug 'Shougo/deoplete.nvim'
"Plug 'neoclide/coc.nvim'

" Cscope wrapper
Plug 'dr-kino/cscope-maps'
"Plug 'ludovicchabant/vim-gutentags'

" Call tree
Plug 'vim-scripts/CCTree'

" GDB integration
Plug 'vim-scripts/Conque-GDB'

" Initialize plugin system
call plug#end()


" Enable GitGutter stuff
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_override_sign_column_highlight = 0

" Enable deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#smartcase = 1

" Git blame stuff
" Show blame info below the statusline instead of using virtual text
let g:blameLineUseVirtualText = 0
" Specify the highlight group used for the virtual text ('Comment' by default)
let g:blameLineVirtualTextHighlight = 'Question'
" Add a prefix to the virtual text (empty by default)
let g:blameLineVirtualTextPrefix = '// '
" Customize format for git blame (Default format: '%an | %ar | %s')
let g:blameLineGitFormat = '%an - %s'
" Refer to 'git-show --format=' man pages for format options)

" Extend GitGutter
function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      1
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction


" FZF settings
let $FZF_DEFAULT_COMMAND = 'ag -g ""' "Use ag to make FZF respect .gitignore

" cscope-fzf integreation
"function! Cscope(option, query)
"  let color = '{ x = $1; $1 = ""; z = $3; $3 = ""; printf "\033[34m%s\033[0m:\033[31m%s\033[0m\011\033[37m%s\033[0m\n", x,z,$0; }'
"  let opts = {
"  \ 'source':  "cscope -dL" . a:option . " " . a:query . " | awk '" . color . "'",
"  \ 'options': ['--ansi', '--prompt', '> ',
"  \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
"  \             '--color', 'fg:188,fg+:222,bg+:#3a3a3a,hl+:104'],
"  \ 'down': '40%'
"  \ }
"  function! opts.sink(lines) 
"    let data = split(a:lines)
"    let file = split(data[0], ":")
"    execute 'e ' . '+' . file[1] . ' ' . file[0]
"  endfunction
"  call fzf#run(opts)
"endfunction
"
"" Invoke command. 'g' is for call graph, kinda.
"nnoremap <silent> <\-g> :call Cscope('0', expand('<cword>'))<CR>
"nnoremap <silent> <\-s> :call Cscope('1', expand('<cword>'))<CR>
"nnoremap <silent> <\-c> :call Cscope('2', expand('<cword>'))<CR>
"nnoremap <silent> <\-m> :call Cscope('3', expand('<cword>'))<CR>
