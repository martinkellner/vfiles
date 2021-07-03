call plug#begin('~/.local/share/nvim/plugged')
Plug 'davidhalter/jedi-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'morhetz/gruvbox'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'terryma/vim-multiple-cursors'
Plug 'morhetz/gruvbox'
Plug 'neomake/neomake'
Plug 'zivyangll/git-blame.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'andviro/flake8-vim'
call plug#end()

" Enable alignment
let g:neoformat_basic_format_align = 1
" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1
" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 1
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

call neomake#configure#automake('nrwi', 500)

let g:neoformat_enabled_python = ['black', 'autopep8']

" Flake8
let g:PyFlakeOnWrite = 1
let g:PyFlakeMaxLineLength = 120
let g:PyFlakeAggressive = 0

call neomake#configure#automake('nrwi', 500)
"syntax on " This is required
set termguicolors
"Unified color scheme (default: dark)
set background=dark
colorscheme onedark

let g:prettier#config#config_precedence = 'file-override'
let g:prettier#config#tab_width = 4
let g:prettier#config#use_tabs = 4

filetype plugin on
set omnifunc=syntaxcomplete#Complete
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" FZF Bindings
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <C-f> :Files<CR>
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:fzf_tag_actions = {
      \ 'checkout': {'execute': '!{git} checkout {branch}'},
      \}
let g:fzf_branch_actions = {
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Git diff {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

" Git plugin bindings
nnoremap <silent> <Leader>g :GitBlame<CR>
nnoremap <silent> <C-g> :Git blame<CR>
" Black formatting
nnoremap <silent> <Leader>nb :Neoformat black<CR>
" NERDTree 
nnoremap <silent> <F3> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1


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
  split term://bash
  resize 10
endfunction
nnoremap <C-t> :call OpenTerminal()<CR>

" Switching between panels
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Map key sequence replacing word by copied one and preserving the copied one,
" by C-j
:map <C-j> ciw<C-r>0<ESC>
