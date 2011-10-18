setlocal formatoptions+=tcqow
setlocal textwidth=70
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
let g:TreatMacViewerAsUNIX=1
let g:tex_flavor='latex'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode -synctex=1 -output-format=pdf $*'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Skim $*.pdf'
let g:Tex_DefaultTargetFormat = 'pdf'
if has('mac')
    let g:Tex_ViewRule_pdf = 'Skim'
elseif has ('unix')
    let g:Tex_ViewRule_pdf = 'evince'
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

