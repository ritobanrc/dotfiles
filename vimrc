syntax on

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree' " File browset
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " highlight filles in nerdtree
Plug 'ryanoasis/vim-devicons'  " icons in nerdtree
Plug 'liuchengxu/vista.vim'  " Better tagbar
Plug 'vim-airline/vim-airline' " Show nicer bar on the bottom
Plug 'vim-airline/vim-airline-themes' " Themes for that nicer bar
"Plug 'davidhalter/jedi-vim' " jedi for python
Plug 'Vimjas/vim-python-pep8-indent'  " Handle hanging indents and multiline stuff properly
"Plug 'tweekmonster/impsort.vim' " Sort imports according to pep7 # TODO!!!
Plug 'tpope/vim-surround'  " For parenthesis and stuff

"" Fast fuzzy searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'junegunn/goyo.vim' " Centering
Plug 'w0rp/ale'  "  linter
Plug 'scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting
" Literally just two autocommands to :noh when I enter insert mode or move away from a search.
Plug 'romainl/vim-cool' 

Plug 'tikhomirov/vim-glsl'  " Syntax Highlighting
Plug 'mboughaba/i3config.vim' " Syntax highlighting i3 config
"Plug 'OrangeT/vim-csharp'
" AutoComplete
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}


" Colorschemes
"Plug 'drewtempelmeyer/palenight.vim' " Pretty color scheme
"Plug 'joshdick/onedark.vim' 
Plug 'morhetz/gruvbox' 
Plug 'ayu-theme/ayu-vim'

"Plug 'bluz71/vim-moonfly-colors'
"Plug 'rakr/vim-one'

call plug#end()

""""""""""""""""""""""""""""""""""""""""
""""""""""  General Stuff  """""""""""""
""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on  " Enable filetype detection, autoindent, and filetype specific plugins
set fileformat=unix
set number relativenumber " Line numberings, relative to current position
set nowrap " Don't wrap lines
autocmd FileType markdown,html,tex set wrap linebreak  " If it's a markup language, wrap and break at spaces or punctuation


set nobackup  " These are also mostly annoying
set noswapfile  " These are mostly annoying. Hopefully we don't have memory problems
set mouse=a  " Give me some basic mouse functionality (scrolling, selecting, etc.)

let mapleader = " " " space should be leader key
" deleting one character shouldn't be put into clipboard
nnoremap x "_x
vnoremap x "_x


""""""""""""""''' Colorscheme '""""""""""""
function! MyHighlights() abort
    " Transparent background - "None" highlight for Non Text and normal
    highlight NonText ctermbg=none 
    highlight Normal guibg=none ctermbg=none
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

"let ayucolor="mirage"   " for dark version of theme
colorscheme gruvbox " Color scheme for text

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
""""""""""  Indentation """""""""""""""
set autoindent  " Keep indent from previous line 
set smarttab  " Make the tab key use tabstop
set expandtab " Use Spaces instead of Tabs 
set shiftwidth=4  " Returns tabstop?
set softtabstop=4  " Number of spaces a <Tab> inserts
set tabstop=8 " Number of spaces an already existing tab is displayed as

"""""""""" Splits '""""""""""""""
set splitright splitbelow " By Default, Splits should open on the right or below
" TODO: Display whitespace
" Use C-hjkl to move between splits
nnoremap <C-h> <C-w>h  
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

""""""""""""" Scrolling """"""""""""""
set scrolloff=8  " Start scrolling 8 lines from the edges. 
set sidescrolloff=10 " Same as previous, except horizontally

"""""""""""""" Searching """""""""""""
set ignorecase " Ignore case, unless it's smart
set smartcase " Smart case sensitivty when searching
set hlsearch " Highlight searches
set incsearch " As I type
set wrapscan " Wrap searching to top of document


""""""""""""""" Navigation """""""""""""""""""""
set hidden
noremap <S-j> :bprevious<CR>
noremap <S-k> :bnext<CR>

nnoremap <tab> :tabn<CR>
""""""""""""""""" Plugins """""""""""""
noremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeLimitedSyntax = 1 " Highlight fewer filetypes for faster NERDTree

" Tagbar
noremap <C-t> :Vista!!<CR>

" FZF
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
nmap <Leader>t :BTags<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>a :Ag<CR>
nmap <Leader>H :Helptags!<CR>

augroup Plugins
    autocmd BufRead */.config/i3/* set filetype=i3config " i3 syntax highlighting
augroup END

" Ale 
let g:ale_sign_error = '~>'
let g:ale_sign_warning = '>'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = '1'
let g:ale_lint_on_save = '1'
let g:ale_sign_column_always = 1
highlight ALEErrorSign guifg=#FF0000
highlight ALEWarningSign guifg=#FFDD00
"nmap <silent> <C-M> <Plug>(ale_previous_wrap)
"nmap <silent> <C-m> <Plug>(ale_next_wrap)
"
" Markdown Sections as Tags
"" Add support for markdown files in tagbar.
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '/home/ritoban/Applications/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

""""""""""" Airline """"""""""""""
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" I don't care about encoding most of the time
let g:airline_section_y = "" 
let g:airline_theme='distinguished'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Show CoC errosin Airline
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

""""""""""  Completion """""""""""
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"
" Remap for rename current word 
nmap <leader>rn <Plug>(coc-rename)

""""""""""" Gotos '"""""""""""""""
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


""""""""""""""  Other Functionality and Shortcuts '"""""""""""""""
augroup AutoRun
    autocmd FileType python nnoremap <leader>w :wa <bar> split <bar> term python %<CR>
    autocmd FileType rust nnoremap <leader>w :wa <bar> split <bar> term cargo run<CR>
    autocmd FileType markdown  nnoremap<leader>w :wa <bar> split <bar> term panrun %<CR>
    autocmd FileType tex,latex  nnoremap<leader>w :wa <bar> split <bar> term pdflatex % <CR>
    autocmd FileType java nnoremap <leader>w :wa <bar> split <bar> term javac % && java $(basename % .java)<CR>
    autocmd FileType sh nnoremap <leader>w :wa <bar> split <bar> term <CR>
augroup END
"""""""""""""" A bunch of mappings '"""""""""""""""""
nnoremap S :%s//g<Left><Left>
inoremap jk <esc>
inoremap kj <esc>
"" Spelling/Spanish mappings
nnoremap <leader>se :set spell spelllang=en<CR>
nnoremap <leader>ss :set spell spelllang=es keymap=accents<CR>
" Debate mappings
nnoremap <leader>dh :new \| set ft=markdown<CR>
nnoremap <leader>dv :vnew \| set ft=markdown<CR>
inoremap <C-l> →<space>
inoremap <C-h> <space>←<space>

" map the command to something much faster
nnoremap <silent> <leader>g :FloatIt<CR>
