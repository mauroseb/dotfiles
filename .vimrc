"
" .vimrc - Mauro S. Oddi - 09.2015
"

" Defaults
set fo=tcq
set nocompatible
set modeline
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showtabline=4
set expandtab
set number
set ruler
set autoindent
" for terminator to set colors properly
set t_Co=256
"set bg=dark
syntax on

" Load pathogen and all the modules
execute pathogen#infect()

" Tab settings
imap ,t <ESC> :newtab<CR>

" Folding settings
"set foldmethod=syntax
set foldlevel=99

" Task lists settings
map <leader>td	<Plug>TaskList

" Puppet/YAML/Ruby/Rspec iand other types settings
au BufRead,BufNewFile *.pp
  \ set filetype=puppet shiftwidth=2 tabstop=2 softtabstop=2 expandtab
au BufRead,BufNewFile *.yml
  \ set filetype=yaml shiftwidth=2 tabstop=2 softtabstop=2 expandtab
au BufRead,BufNewFile *.yaml
  \ set filetype=yaml shiftwidth=2 tabstop=2 softtabstop=2 expandtab
au BufRead,BufNewFile *_spec.rb
  \ nmap <F7> :!rspec --color %<CR>
au BufRead,BufNewFile *.txt
  \ set filetype=text shiftwidth=4 tabstop=4 softtabstop=4 expandtab
au BufRead,BufNewFile *.md
  \ set filetype=markdown shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"au BufRead,BufNewFile *.py
"  \ set filetype=python shiftwidth=4 tabstop=4 softtabstop=4 expandtab
"au BufRead,BufNewFile *.c
  "\ set filetype=c shiftwidth=4 tabstop=4 softtabstop=4 expandtab
"au BufRead,BufNewFile *.h
  "\ set filetype=c shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" Enable indentation matching for =>'s
filetype plugin indent on


" Function to open plugins but focus in the next window
function! s:myVIMOpen()
  call s:NERDTreeOpen()
endfunction


" Function to open NERDTree but focus in the next window
function! s:NERDTreeOpen()
  NERDTreeTabsOpen
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
		if winnr() == bufwinnr(t:NERDTreeBufName)
		wincmd w
      endif
    endif
  endif
endfunction

" Function to close NERDTree if it's the only win left or NERDTree and TagList are the only windows left
function! s:NERDTreeQuit()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      elseif winnr('$') == 2
		if bufexists("__Tag_List__")
          if bufwinnr("__Tag_List__") != -1
				echom "Tag List Open!"
				let tag_list_bufnr  = bufwinnr("__Tag_List__")
				 tag_list_bufnr wincmd w
				q
				q
		  endif
		endif
	  endif
    endif
  endif
endfunction

" Choose color set
color mrx

"set guifont=Monaco:h12
"set guioptions-=T " Removes top toolbar
"set guioptions-=r " Removes right hand scroll bar
"set go-=L " Removes left hand scroll bar
"autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
":set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ commands

" NERDTree settings
"let g:NERDTreeWinPos = "right"
map <leader>n :NERDTreeToggle<CR>
" Arrows fail to draw in some versions and lose functionality.
let g:NERDTreeDirArrows=1
au WinEnter * call s:NERDTreeQuit()

" Custom actions on Open VIM
au VimEnter * call s:myVIMOpen()

" Highlight tabs and whitespaces (should add to mrx color scheme)
highlight LiteralTabs ctermbg=red  guibg=red
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=red  guibg=red
match ExtraWhitespace /\s\+$/
highlight comment ctermfg=cyan


" PEP8 settings
" let g:pep8_map='whatever'
" Ignore some PEP8 Checks
 let g:pep8_ignore="E501,E265"

" Taglist settings
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 30
let Tlist_Auto_Open = 1
let Tlist_Exit_OnlyWindow = 1

" Gitgutter settings
nnoremap <silent> <F9> :GitGutterToggle<CR>

" Airline settings
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_theme='dark'

" NERDTreeTabs
let g:nerdtree_tabs_open_on_console_startup = 1

" Allow saving with sudo
" cmap w!! w !sudo tee % > /dev/null

set paste
"EOF
