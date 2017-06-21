:set fileencodings=utf-8
:set autoread " autorefresh files changed outside of VIM
:set laststatus=2 " required for vim-arline plugin 
syntax on
:color desert
:set cursorline
:set number
:set relativenumber

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree' " file tree navigator
Plugin 'jistr/vim-nerdtree-tabs' " file tree and tabs integration 
Plugin 'tpope/vim-fugitive' " git integration 
Plugin 'scrooloose/syntastic' " source code syntax verification (python etc) 
Plugin 'vim-airline/vim-airline' " fancy statusbar 
Plugin 'ctrlpvim/ctrlp.vim' " file searcher 
Plugin 'christoomey/vim-tmux-navigator' " tmux integration
Plugin 'benmills/vimux' " tmux integration
" disabled - problems with error 413
" Plugin 'valloric/youcompleteme'

" run current file in batch with F5
map <F5> <Esc>:w<CR>:!%:p<CR>
imap <F5> <Esc>:w<CR>:!%:p<CR>
map <F6> :w!<CR>
imap <F6> <Esc>:w!<CR>h
 
map <F7> :w!<CR>:call VimuxRunCommand("clear; " . bufname("%:p"))<CR>
imap <F7> <Esc>:w!<CR>:call VimuxRunCommand("clear; " . bufname("%:p"))<CR>h
map <C-a> :w!<CR>:call VimuxRunCommand("clear; cd " . expand("%:p:h") . "; " . expand("%:p"))<CR>
imap <C-a> <Esc>:w!<CR>:call VimuxRunCommand("clear; cd" . expand("%:p:h") . ";" . expand("%:p"))<CR>h

" make nerd tree use one single instance of nerd tree
map <silent> <leader>n :NERDTreeToggle<CR> :NERDTreeMirror<CR>
" open tree with F2
map <F2> <Esc>:NERDTreeToggle<CR>
imap <F2> <Esc>:NERDTreeToggle<CR>

" move around tabs with ctrl

" Tab navigation like Firefox.
nnoremap <C-u> :tabprevious<CR>
nnoremap <C-i> :tabnext<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-y> :tabclose<CR>
inoremap <C-u> <Esc>:tabprevious<CR>h
inoremap <C-i> <Esc>:tabnext<CR>h
inoremap <C-n> <Esc>:tabnew<CR>
inoremap <C-y> <Esc>:tabclose<CR>

" open new tab on enter in nerd tree (by default is opens new buffer)
let NERDTreeMapOpenInTab='<Space>'

call vundle#end()            " required
filetype plugin indent on    " required

" syntatic configuration (static source code verification)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#tabline#enabled = 1

" file search plugin configuration (ctrl+p)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

nnoremap ,cd :lcd %:p:h<CR>  " working director to current directory after ,cd
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" force proper tab behaviour 
inoremap <Tab> <Tab>

" map arrows to more convinient schema - jikl
noremap i k
noremap j h
noremap k j
" change to insert mode on ctrl+I
noremap h i
" change to normal mode on ctrl+H
imap <C-H> <Esc>

" moving to de beginning and end of line with <- 8 9 ->
noremap 7 0
noremap 8 ^
noremap 9 $

" add new line after/before current line in normal mode with Enter 
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>
" add space in normal mode when spacebar is hit
nnoremap <Space> i<Space><Right><ESC>
" map backspace to delete left char in normal mode
nnoremap <backspace> X

" turn on search results highlighting
set hlsearch

" faster switch to normal mode - dont wait for key sequence 
set timeoutlen=1000 ttimeoutlen=0