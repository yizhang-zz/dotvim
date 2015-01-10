set nocompatible
set nobackup
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/powerline'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'vim-scripts/tComment'
Bundle 'terryma/vim-multiple-cursors'

filetype plugin indent on

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
" set relativenumber
" set undofile
set visualbell
set ttyfast
set title " change the terminal's title
syntax on

" set clipboard=unnamed
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" set iskeyword-=_

" set foldmethod=syntax
" set foldnestmax=3

" use space bar to toggle fold
nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
vnoremap <Space> zf

" regex search
" nnoremap / /\v
" vnoremap / /\v

" global subst
set gdefault

set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
" nnoremap <F5> :b <C-Z>

nmap <f5> :TagbarToggle<cr>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

nnoremap \ ,
let mapleader = ','
let maplocalleader = ','

map <leader>rc :e $MYVIMRC<cr>

" spell settings
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us

" map cmd+enter to start new line, like in Textmate
inoremap <D-CR> <ESC>o

set modelines=5
set popt=paper:letter

" text bubbling: single lines
" nmap <C-Down> ddp 
" nmap <C-Up> ddkP
nmap <C-Up> [e
nmap <C-Down> ]e
" text bubbling: multiple lines
" vmap <C-Up> xkP`[V`]
" vmap <C-Down> xp`[V`]
vmap <C-Up> [egv
vmap <C-Down> ]egv

" can switch to other buffer if current buffer is modified
set hidden

set dy=lastline

" use :cd %:h instead
"if exists('+autochdir')
"	set autochdir
"endif

"set textwidth=78
set ts=4
set backspace=indent,eol,start
set number " for line number
set sw=4
set smarttab
set showmatch
"" expand tab but not for makefiles
"set et
"autocmd BufNewFile,BufRead Makefile :set noet

set fileencodings=utf-8,gbk,ucs-bom,latin1

if has("gui_running")
    set guioptions-=T " no toolbar
	set background=dark
	colorscheme solarized
else
	set t_Co=256
	set background=dark
	colorscheme solarized
endif
if has("gui_macvim")
	set guifont=Droid\ Sans\ Mono:h14
	colorscheme monokai
	" let macvim_hig_shift_movement = 1
    " swipe is broken in Lion
	" nmap <SwipeLeft> :bN<CR>
	" nmap <SwipeRight> :bn<CR>
endif

set guioptions+=aAce

set colorcolumn=80

set incsearch
set hlsearch
set ignorecase
set smartcase
"clear highlighted search
nmap <silent> <leader><space>  :nohlsearch<cr>

" use tab to match parentheses
nnoremap <tab> %
vnoremap <tab> %

"set guitablabel=%N\ %f

set laststatus=2
"set statusline=%n\ %1*%h%f%*\ %=%<[%3lL,%2cC]\ %2p%%\ 0x%02B%r%m
" set statusline=%-3.3n%f[%{strlen(&ft)?&ft:'none'}]%=%-15(%l,%c%V\ %P)\ %{fugitive#statusline()}
let g:Powerline_symbols='fancy'
au BufNewFile,BufRead *.r setf r
au BufNewFile,BufRead *.r set syntax=r

set list
set listchars=tab:»\ ,trail:·,extends:»,precedes:«

" format paragraph
nnoremap <leader>q gwip
" select previously pasted stuff
nnoremap <leader>v V`]
" create vertical split and switch to that window
nnoremap <leader>w <C-w>v<C-w>l
" move around
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" easy tcomment
nmap <leader>c <c-_><c-_>
" easy motion
let g:EasyMotion_leader_key = '<Leader>m'
" for Command-T
"let g:CommandTMaxFiles=500

filetype plugin on
"set shellslash
filetype indent on

au filetype tex set et sw=2 ts=2
" au filetype tex map <leader>q ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gw//-1<CR>
" au filetype tex omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>

let g:tex_flavor = 'pdflatex'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_MultipleCompileFormats='pdf'

au FileType c,cpp  set et sw=4 ts=4 cindent cino=g0:0(0 fo=tcroqn
set tags=tags;/

map <F2> :NERDTreeToggle<CR>

" use gnu global to replace cscope
set cscopetag
set cscopeprg=gtags-cscope
set cscopequickfix=c-,d-,e-,f-,g0,i-,s-,t-
"nmap <silent> <leader>j <ESC>:cstag <c-r><c-w><CR>
"nmap <silent> <leader>g <ESC>:lcs f c <c-r><c-w><cr>:lw<cr>
"nmap <silent> <leader>s <ESC>:lcs f s <c-r><c-w><cr>:lw<cr>
"command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
"au VimEnter * call VimEnterCallback()
"au BufAdd *.[ch] call FindGtags(expand('<afile>'))
"au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

function! FindFiles(pat, ...)
    let path = ''
    for str in a:000
        let path .= str . ','
    endfor

    if path == ''
        let path = &path
    endif

    echo 'finding...'
    redraw
    call append(line('$'), split(globpath(path, a:pat), '\n'))
    echo 'finding...done!'
    redraw
endfunc

function! VimEnterCallback()
    for f in argv()
        if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h'
            continue
        endif

        call FindGtags(f)
    endfor
endfunc

function! FindGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    while 1
        let tmp = dir . '/GTAGS'
        if filereadable(tmp)
            exe 'cs add ' . tmp . ' ' . dir
            break
        elseif dir == '/'
            break
        endif

        let dir = fnamemodify(dir, ":h")
    endwhile
endfunc

function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunc

au FileType notes set tw=78
let g:notes_directory = '~/Dropbox/Personal/notes'
let g:notes_suffix = '.txt'
" let g:notes_indexscript = '~/.vim/bin/xxx'

au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
au BufEnter *.org call org#SetOrgFileType()

" au FileType python set omnifunc=pythoncomplete#Complete
" let g:SuperTabDefaultCompletionType = "context"
" set completeopt=menuone,longest,preview
let python_highlight_all=1

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
 
" Do command and preserve the search register and cursor position
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" strip trailing white spaces
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
" format entire buffer
nmap _= :call Preserve("normal gg=G")<CR>

" text object according to indent level
onoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR>
onoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR>
vnoremap <silent>ai :<C-U>cal <SID>IndTxtObj(0)<CR><Esc>gv
vnoremap <silent>ii :<C-U>cal <SID>IndTxtObj(1)<CR><Esc>gv

function! s:IndTxtObj(inner)
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
  let i = i < 0 ? 0 : i
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction

" edit files in the same dir as the current one
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" vimwiki stuff
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{ 'path': '~/vimwiki',
  \ 'path_html': '~/Sites/vimwiki/',
  \ 'template_path': '~/Sites/vimwiki/template/' }]

" for commentary
if exists("g:loaded_commentary")
	autocmd FileType r set commentstring=#\ %s
endif
