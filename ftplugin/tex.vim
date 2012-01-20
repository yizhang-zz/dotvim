setlocal formatoptions+=tcqo
" setlocal textwidth=70
setlocal sw=2
setlocal iskeyword+=:

" section jumping
function! TexJump2Section( cnt, dir )
  let i = 0
  let pat = '^\\\(part\|chapter\|\(sub\)*section\|paragraph\)\>\|\%$\|\%^'
  let flags = 'W' . a:dir
  while i < a:cnt && search( pat, flags ) > 0
    let i = i+1
  endwhile
  "let @/ = pat
endfunction
"noremap <buffer> <silent> ]] :<c-u>call TexJump2Section( v:count1, '' )<CR>
"noremap <buffer> <silent> [[ :<c-u>call TexJump2Section( v:count1, 'b' )<CR>

" latex-suite settings
let g:Tex_UseMakefile=0
" let g:TreatMacViewerAsUNIX=1
let g:tex_flavor='latex'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode -synctex=1 -output-format=pdf $*'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Skim $*.pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
if has('unix')
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		let g:Tex_ViewRule_pdf = 'open -a Skim'
	else
		let g:Tex_ViewRule_pdf = 'evince'
	endif
endif

" latex-box
"let g:LatexBox_viewer = 'open -a Skim '
"let g:LatexBox_latexmk_options = '-pvc'
imap <buffer> [[ 		\begin{
imap <buffer> ]]		<Plug>LatexCloseCurEnv
nmap <buffer> <F5>		<Plug>LatexChangeEnv
vmap <buffer> <F7>		<Plug>LatexWrapSelection
vmap <buffer> <S-F7>		<Plug>LatexEnvWrapSelection
imap <buffer> (( 		\eqref{

" Reformat lines (getting the spacing correct) {{{
fun! TeX_fmt()
    if (getline(".") != "")
    let save_cursor = getpos(".")
        let op_wrapscan = &wrapscan
        set nowrapscan
		let par_begin = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
		let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\[\|\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
        norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
        let &wrapscan = op_wrapscan
    call setpos('.', save_cursor) 
    endif
endfun

nmap Q :call TeX_fmt()<CR>
"}}}
