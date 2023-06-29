" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

filetype plugin indent on


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set mouse=a		" Enable mouse usage (all modes)
set autoread
set ignorecase
set hlsearch

set so=7

set nu rnu

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set incsearch
set noshowmode
set backspace=indent,eol,start

augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

set ruler
highlight BadWhitespace ctermbg=red guibg=red
set laststatus=2

nnoremap <C-n> :NERDTreeToggle<CR>

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nmap <Leader>pp :RunSilent open /tmp/vim-pandoc-out.pdf<CR>

set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

map <F5> :setlocal spell! spelllang=it_it<CR>
map <F6> :setlocal spell! spelllang=en_us<CR>

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" On-demand loading

Plug 'scrooloose/nerdtree'
Plug '/usr/local/opt/fzf'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'tomasiser/vim-code-dark'
Plug 'lifepillar/vim-solarized8'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'dracula/vim', { 'as': 'dracula' }

" Initialize plugin system
call plug#end()

nnoremap <F3> :!date <CR>P
inoremap <F3> <C-R>=strftime("%c")<CR>
colorscheme dracula
