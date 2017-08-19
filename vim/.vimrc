call plug#begin('~/.vim/plugged')

Plug 'scrooloose/syntastic'
Plug 'plasticboy/vim-markdown'
Plug 'tomtom/tcomment_vim'

call plug#end()

" General {

    filetype plugin indent on

    set mouse=a
    set mousehide
    set shortmess+=filmnrxoOtT


    scriptencoding utf-8

    if !exists('g:no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    set mps+=<:>
    set backspace=2
    set smartcase
    set confirm
    set autoread
    set showmatch
    set smarttab
    set showcmd
    set incsearch
    set nu
    set visualbell t_vb=
    " set t_RV=
    set title
    set cursorline
    " Hightlight column
    set hidden
    set history=100
    set clipboard=unnamedplus
    set scrolloff=10
    set foldenable
" }

" Formatting {
"
    set autowrite
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set nojoinspaces
    set shiftround
    set splitright
    set splitbelow
    set wrap


    let g:omni_complete=1

    augroup vimrcEx
        autocmd!

        autocmd FileType text setlocal spell
        autocmd FileType markdown set nonumber

        " When editing a file, always jump to the last known cursor position.
        " Don't do it for commit messages, when the position is invalid, or when
        " inside an event handler (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif

        " Set syntax highlighting for specific file types
        autocmd BufRead,BufNewFile *.md set filetype=markdown

    augroup END


    set wildchar=<Tab> wildmenu wildmode=full
    set complete=.,w,t
    "
    "set wildmenu
    "set wildmode=list:longest
    set wildignore+=.hg,.git,.svn " Version Controls"
    set wildignore+=*.aux,*.out,*.toc "Latex Indermediate files"
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg "Binary Imgs"
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest "Compiled Object files"
    set wildignore+=*.spl "Compiled speolling world list"
    set wildignore+=*.sw? "Vim swap files"
    set wildignore+=*.DS_Store "OSX SHIT"
    set wildignore+=*.luac "Lua byte code"
    set wildignore+=migrations "Django migrations"
    set wildignore+=*.pyc "Python Object codes"
    set wildignore+=*.orig "Merge resolution files"
" }


" Key (re)mapping {
    "
    let mapleader=';'

    " Windows like movements for long lines with wrap enabled:
    noremap j gj
    noremap k gk

    " Allow saving of files as sudo when I forget to start vim using sudo.
    cmap w!! :w !sudo tee > /dev/null %

    " Do not leave visual mode after visually shifting text
    vnoremap < <gv
    vnoremap > >gv

    " Tab control
    nmap <Leader>tt :tabnew<cr>
    nmap <Leader>tn :tabnext<cr>
    nmap <Leader>tp :tabprevious<cr>
    nmap <Leader>tc :tabclose<cr>

    noremap <leader>W :call StripWhitespace()<CR>

    noremap <leader>B :call EnterSpontaneousMode()<CR>
    noremap <leader>BB :call LeaveSpontaneousMode()<CR>
" }

" Functions {
"
    function! StripWhitespace()
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        :%s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
        inoremap <BS> <ESC>
        inoremap ^H <ESC>
    endfunction

    function! ClearGutters()
        highlight clear SignColumn
        highlight clear LineNr
    endfunction

    function! EnterSpontaneousMode()

        inoremap <buffer> <BS> <ESC>
        " inoremap <buffer> <C> <NOP>
        " inoremap <buffer> <ESC> <NOP>
        " Disable backspace
        " Disable Leaving Insert Mode
    endfunction

    function! LeaveSpontaneousMode()
        iunmap <buffer> <BS>
        " iunmap <buffer> <C>
        " iunmap <buffer> <ESC>
    endfunction


    function! NoDelete()
        inoremap <BS> <Nop>
        inoremap <Del> <Nop>
    endfunction



" Easy tab navigation
nnoremap <C-t>     :tabnew<CR>
nnoremap <C-S-tab> <Esc>:tabprevious<CR>
nnoremap <C-tab>   <Esc>:tabnext<CR>

set textwidth=79

"spell check
set spellfile=~/.vim/spell/en.utf-8.add
nmap  <leader>s     :set invspell spelllang=en<CR>
nmap  <leader>ss    :set spell spelllang=en-basic<CR>

"grammer check
let g:languagetool_jar='/home/hargup/code/LanguageTool-2.8/languagetool-commandline.jar'
nmap <leader>l :LanguageToolCheck<CR>
nmap <leader>ll :LanguageToolClear<CR>

" ;q hardwrap Paragraph
nnoremap <leader>q gqip

" ;J Joins hardwrapped Paragraphs
nnoremap <leader>J vipJ


" autogeneration of ctags
au BufWritePost *.c,*.cpp,*.h,*py silent! !ctags -R --fields=+l &

colorscheme Tomorrow-Night-Eighties

" Insert timestamp
:nnoremap <leader>d  "=strftime("%c")<CR>P

" surround by $ sign for math in using vim-surround
:vmap <leader>m S$
