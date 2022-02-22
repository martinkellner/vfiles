" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

call plug#begin()
" Autocomplete plugin
Plug 'davidhalter/jedi-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'joshdick/onedark.vim'
Plug 'cjrh/vim-conda'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'sheerun/vim-polyglot'
call plug#end()

" Python DLL loading.
" WARN: Path is hardcoded. Change on new env.
" WARN: If using anaconda python, ensure PYTHONHOME points to Anaconda dir.
set pythonthreedll=$HOME\Anaconda3\python39.dll
let g:pymode_python = 'python'

" Mapping for FuzzyFinder
nnoremap <silent> <C-f> :FZF<CR>

" Color scheme
set background=dark
colorscheme onedark

" Switching between panel. Use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Open a new file.
nnoremap <silent> <C-t> :tabe<CR>

" Integrated terminal
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  :terminal
  resize 10
endfunction
nnoremap <A-t> :call OpenTerminal()<CR>

" Automatically removing all trailing whitespace on :w
autocmd BufWritePre * :%s/\s\+$//e
