execute pathogen#infect('bundle/{}', '~/src/dotfiles/vim/bundles/{}')
syntax on
filetype plugin indent on
set backspace=indent,eol,start
set mouse=a
set hidden
set laststatus=2
set background=dark
set number
if $TMUX == ''
  set clipboard+=unnamed
endif
set cursorline
set virtualedit=onemore
set viewoptions=folds,options,cursor,unix,slash
set mousehide

let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
color solarized

" size of a hard tabstop
set tabstop=2
" size of an "indent"
set shiftwidth=2
" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=2
" make "tab" insert indents instead of tabs at the beginning of a line
set smarttab
" always uses spaces instead of tab characters
set expandtab

" Search highlighting.
set hlsearch
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" CtrlP Plugin Configuration.
let g:ctrlp_cmd = 'CtrlP'

function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

" NERDTree Plugin Configuration.
autocmd StdinReadPre * let s:std_in=1
" Open NERDTree automatically if no files are specified.
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-e> :NERDTreeToggle<CR>
" Close Vim automatically if NERDTree is the only thing left.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")

" Limelight Plugin Configuration.
map <C-l> :Limelight!!<CR>

" Vim-Go Plugin Configuration.
map <C-t> :GoTest ./...<CR>
map <C-c> :GoCoverage<CR>

" Ctags / TagBar Plugin Configuration.
let g:tagbar_ctags_bin='/opt/boxen/homebrew/bin/ctags'
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
let g:tagbar_show_linenumbers = 1
autocmd FileType * nested :call tagbar#autoopen(0)
autocmd VimEnter * nested :call tagbar#autoopen(1)

