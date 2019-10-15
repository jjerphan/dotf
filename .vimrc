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
    call plug#end()

" => Fix misspell on the fly!
    setlocal spell
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

	" Word count:
	map <leader>w :w !detex \| wc -w<CR>
	" Code snippets
	inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
	inoremap ,ft \footnote{}<++><Esc>T{i
	inoremap ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
	inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
	inoremap ,em \emph{}<++><Esc>T{i
	inoremap ,bf \textbf{}<++><Esc>T{i
	vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	inoremap ,it \textit{}<++><Esc>T{i
	inoremap ,ct \textcite{}<++><Esc>T{i
	inoremap ,cp \parencite{}<++><Esc>T{i
	inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
	inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
	inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
	inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
	inoremap ,li <Enter>\item<Space>
	inoremap ,ref \ref{}<Space><++><Esc>T{i
	inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
	inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
	inoremap ,can \cand{}<Tab><++><Esc>T{i
	inoremap ,con \const{}<Tab><++><Esc>T{i
	inoremap ,v \vio{}<Tab><++><Esc>T{i
	inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
	inoremap ,sc \textsc{}<Space><++><Esc>T{i
	inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
	inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
	inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
	inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
	inoremap ,st <Esc>F{i*<Esc>f}i
	inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
	inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
	nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
	inoremap ,tt \texttt{}<Space><++><Esc>T{i
	inoremap ,bt {\blindtext}
	inoremap ,nu $\varnothing$
	inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
	inoremap ,rn (\ref{})<++><Esc>F}i

""" => End Latex
