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

" Sections:
"    -> Plugins
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> Helper functions
"    -> Misc
"


" => Plugins
    call plug#begin('~/.vim/plugged')
        Plug 'junegunn/goyo.vim'
        Plug 'JuliaEditorSupport/julia-vim'
    call plug#end()

" => General
    set encoding=utf8
    let mapleader = " "
    set history=500
    filetype plugin on
    filetype indent on
    command W w !sudo tee % > /dev/null
    set ffs=unix,dos,mac
    set wildmode=longest,list,full

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
    set wrap "Wrap lines

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

" => Misc
    "source $HOME/.vimrclatex
