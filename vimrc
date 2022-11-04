" PLUGINS TO INSTALL.
" -----------------------
call plug#begin()
Plug 'davidhalter/jedi-vim'                           "Autocomplete for python.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }   "Files and string finder.
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'                           "Color theme.
Plug 'dense-analysis/ale'                             "Python linting. Ensure pylint is installed.
Plug 'jiangmiao/auto-pairs'                           "Autopairing for parenthesis, quotes, ...
Plug 'preservim/nerdcommenter'                        "Adding comments.
Plug 'sheerun/vim-polyglot'                           "Highlighting and more for many languages.
Plug 'tpope/vim-fugitive'                             "Git wrapper into Vim.
Plug 'jmcantrell/vim-virtualenv'
call plug#end()

" PYTHON SETTINGS
" -----------------------
" Loading DLL on Windows
set pythonthreedll=python39.dll
"let g:pymode_python = 'python'

" APPEARANCE SETTINGS
" -----------------------
set background=dark
colorscheme onedark
" Setting Font based on the actual platform.
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

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

" Open integrated terminal on vertical split.
nnoremap <A-t> :vert term<CR>

set splitright
set splitbelow
tnoremap <Esc> <C-\><C-n>
au BufEnter * if &buftype == 'vert terminal' | :startinsert | endif
function! OpenTerminal()
     :vert terminal
endfunction
nnoremap <A-t> :call OpenTerminal()<CR>

" Spell control turn on.
nnoremap <A-s> :set spell spelllang=en<CR>
" Spell control turn off.
nnoremap <A-d> :set nospell<CR>
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" AUTOCOMMANDS
" -----------------------
" Removing all trailing whitespace on write.
autocmd BufWritePre * :%s/\s\+$//e
augroup python
    au!
    " Set colomn line on 79 (based on PEP8 recommendations) for Python files.
    autocmd FileType python set colorcolumn=80
augroup END

" VIM OPTIONS
" -----------------------
" Turn off creating .un~ files.
set noundofile
" Ensure line numbering is set on.
set number
" Set search matches to be highlighed by default.
set hlsearch
" Set status line - note that is depends on Fugitive.
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" PLUGINS
" -----------------------
" FUZZYFINDER
" Dependencies
"   - ripgrep (https://github.com/BurntSushi/ripgrep)
"
" Settings
"
" This is okay in most cases because fzf is quite performant even with millions of lines,
" but we can make fzf completely delegate its search responsibliity to ripgrep process by making it restart ripgrep
" whenever the query string is updated. In this scenario, fzf becomes a simple selector interface rather than a "fuzzy finder".
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" Mapping for FuzzyFinder
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <C-f> :Files<CR>
"let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
let $FZF_DEFAULT_COMMAND = 'rg --files --follow --glob "!.git/*"'

" FUGITIVE
" Dependencies
"   - git
"
" Settings
"
" Set shortcut for Git blame to show authors of last commits per line.
noremap <leader>b :Git blame<CR>

" ALE
" Settings
" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0

" JEDI
" Settings
let g:jedi#completions_enabled = 1
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
