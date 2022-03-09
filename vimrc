" PLUGINS TO INSTALL.
" -----------------------
call plug#begin()
Plug 'davidhalter/jedi-vim'                           "Autocomplete for python.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   "Files and string finder.
Plug 'joshdick/onedark.vim'                           "Color theme.
Plug 'cjrh/vim-conda'                                 "Conda environment switching.
Plug 'dense-analysis/ale'                             "Python linting.
Plug 'jiangmiao/auto-pairs'                           "Autopairing for parenthesis, quotes, ...
Plug 'preservim/nerdcommenter'                        "Adding comments.
Plug 'sheerun/vim-polyglot'                           "Highlighting and more for many languages.
Plug 'puremourning/vimspector'                        "Python debugger.
call plug#end()

" PYTHON SETTINGS
" -----------------------
" Loading DLL on Windows
" TODO: Put under conditions to work on win and linux as well.
set pythonthreedll=$HOME\Anaconda3\python39.dll
let g:pymode_python = 'python'

" APPEARANCE SETTINGS
" -----------------------
set background=dark
colorscheme onedark

" CONTROL SETTINGS
" -----------------------
" Switching between splits.
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

" Open integrated terminal.
set splitright
set splitbelow
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
function! OpenTerminal()
  " TODO: Add a condition to call zsh on linux machines.
  :terminal
  resize 10
endfunction
nnoremap <A-t> :call OpenTerminal()<CR>

" Spell control turn on.
nnoremap <A-s> :set spell spelllang=en<CR>
" Spell control turn off.
nnoremap <A-d> :set nospell<CR>

" AUTOCOMMANDS
" -----------------------
" Removing all trailing whitespace on write.
autocmd BufWritePre * :%s/\s\+$//e

" VIM OPTIONS
" -----------------------
" Turn off creating .un~ files.
set noundofile

" PLUGINS
" -----------------------
" Fuzzyfinder settings
" Mapping for FuzzyFinder
nnoremap <silent> <C-f> :FZF<CR>
