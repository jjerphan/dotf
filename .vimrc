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
" Sections:
"    -> Plugins
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Status line
"    -> Moving around, tabs and buffers
"    -> Helper functions
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


"                    ___                         ___           ___
"                   /\  \                       /\__\         /|  |
"                  /::\  \         ___         /:/ _/_       |:|  |
"                 /:/\:\  \       /\__\       /:/ /\__\      |:|  |
"  ___     ___   /:/ /::\  \     /:/  /      /:/ /:/ _/_   __|:|__|
" /\  \   /\__\ /:/_/:/\:\__\   /:/__/      /:/_/:/ /\__\ /::::\__\_____
" \:\  \ /:/  / \:\/:/  \/__/  /::\  \      \:\/:/ /:/  / ~~~~\::::/___/
"  \:\  /:/  /   \::/__/      /:/\:\  \      \::/_/:/  /      |:|~~|
"   \:\/:/  /     \:\  \      \/__\:\  \      \:\/:/  /       |:|  |
"    \::/  /       \:\__\          \:\__\      \::/  /        |:|__|
"     \/__/         \/__/           \/__/       \/__/         |/__/


" Navigating with guides
	inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
	vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
    map <Space><Tab> <Esc>/<++><Enter>"_c4l

" Code snippets
    autocmd FileType tex inoremap ,fr \begin{frame}<CR>\frametitle{}<CR><CR><++><CR><CR>\end{frame}<CR><CR><++><Esc>6kf}i
    autocmd FileType tex inoremap ,fi \begin{fitch}<CR><CR>\end{fitch}<CR><CR><++><Esc>3kA
    autocmd FileType tex inoremap ,exe \begin{exe}<CR>\ex<Space><CR>\end{exe}<CR><CR><++><Esc>3kA
    autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
    autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
    autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<CR>a
    autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
    autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
    autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
    autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<CR><++><Space>\\<CR>\trans{``<++>''}}<Esc>2k2bcw
    autocmd FileType tex inoremap ,x \begin{xlist}<CR>\ex<Space><CR>\end{xlist}<Esc>kA<Space>
    autocmd FileType tex inoremap ,ol \begin{enumerate}<CR><CR>\end{enumerate}<CR><CR><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ,ul \begin{itemize}<CR><CR>\end{itemize}<CR><CR><++><Esc>3kA\item<Space>
    autocmd FileType tex inoremap ,li <CR>\item<Space>
    autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ,tab \begin{tabular}<CR><++><CR>\end{tabular}<CR><CR><++><Esc>4kA{}<Esc>i
    autocmd FileType tex inoremap ,ot \begin{tableau}<CR>\inp{<++>}<Tab>\const{<++>}<Tab><++><CR><++><CR>\end{tableau}<CR><CR><++><Esc>5kA{}<Esc>i
    autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
    autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
    autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ,chap \chapter{}<CR><CR><++><Esc>2kf}i
    autocmd FileType tex inoremap ,sec \section{}<CR><CR><++><Esc>2kf}i
    autocmd FileType tex inoremap ,ssec \subsection{}<CR><CR><++><Esc>2kf}i
    autocmd FileType tex inoremap ,sssec \subsubsection{}<CR><CR><++><Esc>2kf}i
    autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
    autocmd FileType tex inoremap ,beg \begin{DELRN}<CR><++><CR>\end{DELRN}<CR><CR><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<CR>c
    autocmd FileType tex inoremap ,up <Esc>/usepackage<CR>o\usepackage{}<Esc>i
    autocmd FileType tex nnoremap ,up /usepackage<CR>o\usepackage{}<Esc>i
    autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
    autocmd FileType tex inoremap ,bt {\blindtext}
    autocmd FileType tex inoremap ,nu $\varnothing$
    autocmd FileType tex inoremap ,col \begin{columns}[T]<CR>\begin{column}{.5\textwidth}<CR><CR>\end{column}<CR>\begin{column}{.5\textwidth}<CR><++><CR>\end{column}<CR>\end{columns}<Esc>5kA
    autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

""" => End Latex
