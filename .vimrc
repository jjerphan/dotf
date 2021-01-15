"      ___                       ___           ___           ___
"     /\__\          ___        /\__\         /\  \         /\  \
"    /:/  /         /\  \      /::|  |       /::\  \       /::\  \
"   /:/  /          \:\  \    /:|:|  |      /:/\:\  \     /:/\:\  \
"  /:/__/  ___      /::\__\  /:/|:|__|__   /::\~\:\  \   /:/  \:\  \
"  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ /:/\:\ \:\__\ /:/__/ \:\__\
"  |:|  |/:/  / /\/:/  /    \/__/~~/:/  / \/_|::\/:/  / \:\  \  \/__/
"  |:|__/:/  /  \::/__/           /:/  /     |:|::/  /   \:\  \
"   \::::/__/    \:\__\          /:/  /      |:|\/__/     \:\  \
"    ~~~~         \/__/         /:/  /       |:|  |        \:\__\
"                               \/__/         \|__|         \/__/
"
"
"  Sections:
"    -> General
"    -> Plugins
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Status line
"    -> Moving around, tabs and buffers
"    -> Helper functions
"


" => General
    set encoding=utf8
    let mapleader =","
    set history=500

    filetype plugin on
    filetype indent on
    command W w !sudo tee % > /dev/null
    set ffs=unix,dos,mac
    set wildmode=longest,list,full

" => Plugins
    call plug#begin('~/.vim/plugged')
        Plug 'junegunn/goyo.vim'
        Plug 'JuliaEditorSupport/julia-vim'

        " LaTeX
        Plug 'lervag/vimtex'
            let g:tex_flavor='latex'
            let g:vimtex_view_method='zathura'
            let g:vimtex_quickfix_mode=0
        Plug 'sirver/ultisnips'
            let g:UltiSnipsExpandTrigger = '<tab>'
            let g:UltiSnipsJumpForwardTrigger = '<tab>'
            let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
        Plug 'KeitaNakamura/tex-conceal.vim'
            set conceallevel=1
            let g:tex_conceal='abdmg'
        Plug 'drewtempelmeyer/palenight.vim'
        Plug 'vim-airline/vim-airline'

        " C++
        Plug 'Valloric/YouCompleteMe'
        Plug 'vim-syntastic/syntastic'

        " CPython
        Plug 'tpope/vim-fugitive'
        Plug 'majutsushi/tagbar'
    call plug#end()

    " Trigger tagbar automatically in Python files
    autocmd FileType c call tagbar#autoopen(0)
    autocmd FileType python call tagbar#autoopen(0)

    " Show status bar
    set laststatus=2

    " Set status as current git branch
    set statusline=%{FugitiveStatusline()}

    set background=dark
    colorscheme palenight
    "let g:lightline.colorscheme = 'palenight'
    let g:airline_theme = 'palenight'

    " => Fix misspell on the fly!
    " setlocal spell
    set spelllang=en_us
    inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" => VIM user interface
    let $LANG='en'
    set langmenu=en
    set so=10
    set magic
    set smartcase
    set incsearch

" => Colors and Fonts
    syntax enable
    colo torte

" => Text, tab and indent related
    set expandtab
    set smarttab
    set shiftwidth=4
    set tabstop=4
    set lbr
    set tw=500
    set ai "Auto indent
    set si "Smart indent

    " Words wrapping
    set tw=79
    setl fo=aw2tq
    " set wrap "Wrap lines

    " Deletes trailing whitespace on save.
    autocmd BufWritePre * %s/\s\+$//e

" => Moving around, tabs, windows and buffers
    map <leader>f /

    set splitbelow splitright

    " Smart way to move between windows
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    " Useful mappings for managing tabs
    map <leader>tn :tabnew<cr>
    map <leader>to :tabonly<cr>
    map <leader>tc :tabclose<cr>
    map <leader>tm :tabmove
    map <leader>t<leader> :tabnext

    " Expected behavior of going left or right
    " at the beginning or end of line
    set whichwrap+=<,>,h,l[,]

    set number relativenumber

    augroup numbertoggle
      autocmd!
      autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
      autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END

" => Status line
    " Always show the status line
    set laststatus=2

    set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" => Helper functions
    " Returns true if paste mode is enabled
    function! HasPaste()
        if &paste
            return 'PASTE MODE  '
        endif
        return ''
    endfunction

" => Fortran

    let fortran_free_source=1
    let fortran_have_tabs=1
    let fortran_more_precise=1
    let fortran_do_enddo=1

