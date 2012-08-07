let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <Plug>ZenCodingAnchorizeSummary :call zencoding#anchorizeURL(1)a
inoremap <Plug>ZenCodingAnchorizeURL :call zencoding#anchorizeURL(0)a
inoremap <Plug>ZenCodingRemoveTag :call zencoding#removeTag()a
inoremap <Plug>ZenCodingSplitJoinTagInsert :call zencoding#splitJoinTag()
inoremap <Plug>ZenCodingToggleComment :call zencoding#toggleComment()a
inoremap <Plug>ZenCodingImageSize :call zencoding#imageSize()a
inoremap <Plug>ZenCodingPrev :call zencoding#moveNextPrev(1)
inoremap <Plug>ZenCodingNext :call zencoding#moveNextPrev(0)
inoremap <Plug>ZenCodingBalanceTagOutwardInsert :call zencoding#balanceTag(-1)
inoremap <Plug>ZenCodingBalanceTagInwardInsert :call zencoding#balanceTag(1)
inoremap <Plug>ZenCodingExpandWord u:call zencoding#expandAbbr(1,"")a
inoremap <Plug>ZenCodingExpandAbbr u:call zencoding#expandAbbr(0,"")a
inoremap <silent> <S-Tab> =BackwardsSnippet()
inoremap <C-Tab> 	
map  h
xmap <NL> j
nmap <NL> j
snoremap <silent> <NL> i<Right>=TriggerSnippet()
omap <NL> j
map  k
map  l
map  :sb 
map  <NL>:q:botright cw 10
snoremap  b<BS>
nmap A <Plug>ZenCodingAnchorizeSummary
nmap a <Plug>ZenCodingAnchorizeURL
nmap k <Plug>ZenCodingRemoveTag
nmap j <Plug>ZenCodingSplitJoinTagNormal
vmap m <Plug>ZenCodingMergeLines
nmap / <Plug>ZenCodingToggleComment
nmap i <Plug>ZenCodingImageSize
nmap N <Plug>ZenCodingPrev
nmap n <Plug>ZenCodingNext
vmap D <Plug>ZenCodingBalanceTagOutwardVisual
nmap D <Plug>ZenCodingBalanceTagOutwardNormal
vmap d <Plug>ZenCodingBalanceTagInwardVisual
nmap d <Plug>ZenCodingBalanceTagInwardNormal
nmap , <Plug>ZenCodingExpandWord
nmap  <Plug>ZenCodingExpandNormal
vmap  <Plug>ZenCodingExpandVisual
map   /
vnoremap <silent> # :call VisualSearch('b')
vnoremap $w `>a"`<i"
vnoremap $q `>a'`<i'
vnoremap $$ `>a"`<i"
vnoremap $3 `>a}`<i{
vnoremap $2 `>a]`<i[
vnoremap $1 `>a)`<i(
snoremap % b<BS>%
snoremap ' b<BS>'
vnoremap <silent> * :call VisualSearch('f')
nmap <silent> ,w,t <Plug>VimwikiTabMakeDiaryNote
nmap <silent> ,w,w <Plug>VimwikiMakeDiaryNote
nmap <silent> ,w,i <Plug>VimwikiDiaryGenerateLinks
nmap <silent> ,wi <Plug>VimwikiDiaryIndex
nmap <silent> ,ws <Plug>VimwikiUISelect
nmap <silent> ,wt <Plug>VimwikiTabIndex
nmap <silent> ,ww <Plug>VimwikiIndex
noremap ,m mmHmt:%s///ge'tzt'm
map ,c :botright cw 10
map ,p :cp
map ,n :cn
map <silent> , :noh
map ,y :YRShow
map ,s? z=
map ,sa zg
map ,sp [s
map ,sn ]s
map ,t4 :set shiftwidth=4
map ,t2 :set shiftwidth=2
map ,q :e ~/buffer
map ,cd :cd %:p:h
map ,tm :tabmove 
map ,tc :tabclose
map ,te :tabedit 
map ,tn :tabnew %
nmap ,fu :se ff=unix
nmap ,fd :se ff=dos
map ,5 :set syntax=markdown
map ,$ :syntax sync fromstart
map ,4 :set syntax=javascript
map ,3 :set syntax=python
map ,2 :set syntax=xhtml
map ,1 :set syntax=cheetah
nmap ,f :find
nmap ,w :w!
map 0 ^
imap ° 0i
imap ¤ $a
imap ì :exec "normal f" . leavechara
snoremap U b<BS>U
snoremap \ b<BS>\
snoremap ^ b<BS>^
snoremap ` b<BS>`
nmap gx <Plug>NetrwBrowseX
xmap <Right> :bn
nmap <Right> :bn
xmap <Left> :bp
nmap <Left> :bp
vmap <F7> :call Python_Eval_VSplit() 
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap <Plug>ZenCodingAnchorizeSummary :call zencoding#anchorizeURL(1)
nnoremap <Plug>ZenCodingAnchorizeURL :call zencoding#anchorizeURL(0)
nnoremap <Plug>ZenCodingRemoveTag :call zencoding#removeTag()
nnoremap <Plug>ZenCodingSplitJoinTagNormal :call zencoding#splitJoinTag()
vnoremap <Plug>ZenCodingMergeLines :call zencoding#mergeLines()
nnoremap <Plug>ZenCodingToggleComment :call zencoding#toggleComment()
nnoremap <Plug>ZenCodingImageSize :call zencoding#imageSize()
nnoremap <Plug>ZenCodingPrev :call zencoding#moveNextPrev(1)
nnoremap <Plug>ZenCodingNext :call zencoding#moveNextPrev(0)
vnoremap <Plug>ZenCodingBalanceTagOutwardVisual :call zencoding#balanceTag(-2)
nnoremap <Plug>ZenCodingBalanceTagOutwardNormal :call zencoding#balanceTag(-1)
vnoremap <Plug>ZenCodingBalanceTagInwardVisual :call zencoding#balanceTag(2)
nnoremap <Plug>ZenCodingBalanceTagInwardNormal :call zencoding#balanceTag(1)
nnoremap <Plug>ZenCodingExpandWord :call zencoding#expandAbbr(1,"")
nnoremap <Plug>ZenCodingExpandNormal :call zencoding#expandAbbr(3,"")
vnoremap <Plug>ZenCodingExpandVisual :call zencoding#expandAbbr(2,"")
map <F6> a=strftime("%Y-%m-%d %H:%M:%S") 
map <F2> :%s/\s*$//g:noh''
map <F8> :new:read !svn diff:set syntax=diff buftype=nofilegg
map <F9> ggVGg?
omap <Left> :bp
omap <Right> :bn
map <C-Space> ?
imap  alert();hi
cnoremap  <Home>
cnoremap  <End>
inoremap  
imap 	 <Plug>SuperTabForward
inoremap <silent> <NL> =TriggerSnippet()
cnoremap  
imap  <Plug>SuperTabBackward
imap  
inoremap <silent> 	 =ShowAvailableSnips()
imap  console.log();hi
inoremap  :set pastemui+mv'uV'v=:set nopaste
imap A <Plug>ZenCodingAnchorizeSummary
imap a <Plug>ZenCodingAnchorizeURL
imap k <Plug>ZenCodingRemoveTag
imap j <Plug>ZenCodingSplitJoinTagInsert
imap / <Plug>ZenCodingToggleComment
imap i <Plug>ZenCodingImageSize
imap N <Plug>ZenCodingPrev
imap n <Plug>ZenCodingNext
imap D <Plug>ZenCodingBalanceTagOutwardInsert
imap d <Plug>ZenCodingBalanceTagInwardInsert
imap ; <Plug>ZenCodingExpandWord
imap  <Plug>ZenCodingExpandAbbr
cnoremap $td tabnew ~/Desktop/
cnoremap $th tabnew ~/
cnoremap $tc eCurrentFileDir("tabnew")
cnoremap $c e eCurrentFileDir("e")
cnoremap $q eDeleteTillSlash()
cnoremap $j e ./
cnoremap $d e ~/Desktop/
cnoremap $h e ~/
inoremap $w "":let leavechar='"'i
inoremap $q '':let leavechar="'"i
inoremap $3 {}:let leavechar="}"i
inoremap $4 {o}:let leavechar="}"O
inoremap $2 []:let leavechar="]"i
inoremap $1 ():let leavechar=")"i
imap <d-l> :exec "normal f" . leavechara
imap <D-0> 0i
imap <D-$> $a
vmap ë :m'<-2`>my`<mzgv`yo`z
vmap ê :m'>+`<my`>mzgv`yo`z
nmap ë mz:m-2`z
nmap ê mz:m+`z
iabbr xname Teddy Fish
iabbr tdate =strftime("=%d%m%Y")
iabbr xdate =strftime("%d/%m/%y %H:%M:%S")
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set autoread
set autowriteall
set background=dark
set backspace=eol,start,indent
set cindent
set cmdheight=2
set completeopt=menu
set cscopeprg=/usr/bin/cscope
set cscopetag
set cscopetagorder=1
set cscopeverbose
set dictionary=~/.vim/ftplugin/css.txt,~/.vim/ftplugin/javascript.txt
set errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
set expandtab
set fileencodings=ucs-bom,utf-8,GB18030,gbk
set fileformats=unix,dos,mac
set foldlevelstart=1
set grepprg=grep\ -nH\ $*
set guifont=Panic\ Sans\ 12
set guifontwide=WenQuanYi\ Zen\ Hei\ 12
set helplang=en
set hidden
set history=400
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set listchars=tab:▸\ ,eol:¬
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set matchtime=2
set mouse=a
set omnifunc=csscomplete#CompleteCSS
set pastetoggle=<F3>
set printoptions=paper:letter
set ruler
set runtimepath=~/.vim,~/.vim/bundle/OmniCppComplete,~/.vim/bundle/html5,~/.vim/bundle/javascript.vim,~/.vim/bundle/nerdtree,~/.vim/bundle/snipMate,~/.vim/bundle/supertab,~/.vim/bundle/tag_list,~/.vim/bundle/tlib_vim,~/.vim/bundle/tplugin_vim,~/.vim/bundle/vim-addon-mw-utils,~/.vim/bundle/vim-colors-solarized,~/.vim/bundle/vim-pathogen,~/.vim/bundle/vim-task,~/.vim/bundle/vimwiki,~/.vim/bundle/vimwiki.old,~/.vim/bundle/zencoding-vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim73,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/bundle/OmniCppComplete/after,~/.vim/bundle/snipMate/after,~/.vim/after
set scrolloff=7
set shiftwidth=2
set showmatch
set showtabline=2
set smartindent
set smarttab
set statusline=\ %f%m%r%h\ %y%{\"[\".(&fenc==\"\"?&enc:&fenc).\"]\"}\ \ CWD:\ %r%{CurDir()}%h\ \ Line:\ %l/%L:%c
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set noswapfile
set switchbuf=usetab
set textwidth=500
set viminfo='10,\"100,:20,%,n~/.viminfo
set whichwrap=b,s,<,>,h,l
set wildignore=*.pyc
set wildmenu
set nowritebackup
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/projects/puddingblog
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +56 static/styles/admin.css
badd +11 ~/Documents/Wiki/Default/diary/2012-07-30.wiki
badd +8 ~/Documents/tblog/pelican.conf.py
badd +6 ~/Documents/tblog/src/tpl.md
badd +56 ~/Documents/tblog/Makefile
badd +838 ~/.vimrc
badd +49 controllers/adminviews.py
badd +10 admin.py
badd +2 templates/admin/index.html
badd +7 static/sql/tables.sql
badd +4 templates/admin/entries.html
badd +19 templates/admin/base.html
badd +8 static/styles/style.css
badd +12 ~/projects/aplus/static/styles/style.css
badd +12 controllers/views.py
badd +18 templates/admin/entryEdit.html
badd +19 static/sql/insert.sql
badd +8 config/url.py
badd +6 form.py
badd +10 templates/base.html
badd +31 static/js/markitup/sets/default/set.js
badd +12 static/js/markitup/sets/markdown/style.css
badd +14 templates/admin/comments.html
badd +11 forms.py
badd +4 templates/admin/commentEdit.html
badd +4 templates/admin/tags.html
badd +8 templates/admin/tagEdit.html
badd +4 templates/admin/categories.html
badd +2 static/sql/category.sql
badd +9 ~/Documents/Wiki/Default/index.wiki
badd +4 ~/Documents/Wiki/Default/HowTos.wiki
badd +54 ~/Documents/Wiki/Default/MySQLHowTos.wiki
badd +13 ~/Documents/Wiki/Default/Markdown.wiki
badd +4 templates/admin/categoryEdit.html
badd +4 templates/admin/links.html
badd +7 templates/admin/linkEdit.html
badd +38 templates/admin/entryAdd.html
badd +2 templates/admin/add.html
badd +1 templates/admin/tagAdd.html
badd +4 templates/admin/categoryAdd.html
badd +3 ~/Documents/Wiki/Default/diary/2012-08-04.wiki
badd +2 ~/Documents/Wiki/Default/diary/diary.wiki
badd +1 ~/Documents/Wiki/Default/diary/2012-05-25.wiki
badd +5 templates/admin/linkAdd.html
badd +23 pblog.py
badd +8 ../aplus/aplus.py
badd +1 ~/Documents/Wiki/Default/diary/2012-08-07.wiki
badd +27 templates/admin/login.html
args controllers/adminviews.py
edit controllers/adminviews.py
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
noremap <buffer> <silent> ,tk :call Toggle_task_status()
map <buffer> ,  :w!:!python %
noremap <buffer> <silent> <C-D-CR> :call Toggle_task_status()
inoremap <buffer> $d """"""O
inoremap <buffer> $p print 
inoremap <buffer> $i import 
inoremap <buffer> $c ### #kla
inoremap <buffer> $s self 
inoremap <buffer> $r return 
inoremap <buffer> <silent> <C-D-CR> :call Toggle_task_status()i
inoreabbr <buffer> cifelse =IMAP_PutTextWithMovement("if <++>:\n<++>\nelse:\n<++>")
inoreabbr <buffer> cif =IMAP_PutTextWithMovement("if <++>:\n<++>")
inoreabbr <buffer> cfor =IMAP_PutTextWithMovement("for <++> in <++>:\n<++>")
inoreabbr <buffer> cclass =IMAP_PutTextWithMovement("class <++>:\n<++>")
inoreabbr <buffer> cfun =IMAP_PutTextWithMovement("def <++>(<++>):\n<++>\nreturn <++>")
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'python'
setlocal filetype=python
endif
setlocal foldcolumn=0
set nofoldenable
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcq
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=2
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
set linebreak
setlocal linebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=pythoncomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'python'
setlocal syntax=python
endif
setlocal tabstop=4
setlocal tags=
setlocal textwidth=500
setlocal thesaurus=
setlocal noundofile
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
18
normal zo
19
normal zo
20
normal zo
22
normal zo
19
normal zo
18
normal zo
26
normal zo
27
normal zo
32
normal zo
35
normal zo
37
normal zo
37
normal zo
37
normal zo
37
normal zo
37
normal zo
37
normal zo
37
normal zo
37
normal zo
37
normal zo
39
normal zo
40
normal zo
39
normal zo
35
normal zo
47
normal zo
48
normal zo
32
normal zo
26
normal zo
51
normal zo
52
normal zo
51
normal zo
57
normal zo
60
normal zo
57
normal zo
74
normal zo
76
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
77
normal zo
76
normal zo
74
normal zo
82
normal zo
85
normal zo
92
normal zo
96
normal zo
97
normal zo
97
normal zo
97
normal zo
97
normal zo
97
normal zo
97
normal zo
97
normal zo
97
normal zo
97
normal zo
100
normal zo
104
normal zo
106
normal zo
108
normal zo
111
normal zo
106
normal zo
104
normal zo
96
normal zo
116
normal zo
92
normal zo
82
normal zo
121
normal zo
123
normal zo
128
normal zo
130
normal zo
130
normal zo
130
normal zo
130
normal zo
130
normal zo
130
normal zo
130
normal zo
130
normal zo
130
normal zo
128
normal zo
135
normal zo
123
normal zo
139
normal zo
142
normal zo
149
normal zo
149
normal zo
149
normal zo
149
normal zo
149
normal zo
149
normal zo
149
normal zo
149
normal zo
149
normal zo
142
normal zo
139
normal zo
160
normal zo
165
normal zo
166
normal zo
179
normal zo
180
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
182
normal zo
184
normal zo
185
normal zo
185
normal zo
185
normal zo
184
normal zo
189
normal zo
180
normal zo
179
normal zo
195
normal zo
196
normal zo
197
normal zo
197
normal zo
197
normal zo
197
normal zo
197
normal zo
197
normal zo
197
normal zo
197
normal zo
197
normal zo
200
normal zo
196
normal zo
195
normal zo
166
normal zo
205
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
206
normal zo
208
normal zo
209
normal zo
209
normal zo
209
normal zo
208
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
212
normal zo
216
normal zo
205
normal zo
218
normal zo
165
normal zo
221
normal zo
160
normal zo
121
normal zo
227
normal zo
230
normal zo
234
normal zo
238
normal zo
239
normal zo
238
normal zo
230
normal zo
227
normal zo
248
normal zo
251
normal zo
248
normal zo
256
normal zo
258
normal zo
271
normal zo
273
normal zo
276
normal zo
271
normal zo
256
normal zo
281
normal zo
283
normal zo
281
normal zo
287
normal zo
289
normal zo
287
normal zo
294
normal zo
296
normal zo
302
normal zo
305
normal zo
308
normal zo
302
normal zo
294
normal zo
312
normal zo
314
normal zo
324
normal zo
326
normal zo
327
normal zo
327
normal zo
327
normal zo
326
normal zo
330
normal zo
324
normal zo
312
normal zo
335
normal zo
337
normal zo
335
normal zo
343
normal zo
345
normal zo
343
normal zo
350
normal zo
352
normal zo
358
normal zo
361
normal zo
362
normal zo
362
normal zo
362
normal zo
361
normal zo
365
normal zo
358
normal zo
350
normal zo
369
normal zo
371
normal zo
382
normal zo
384
normal zo
385
normal zo
385
normal zo
385
normal zo
384
normal zo
388
normal zo
382
normal zo
369
normal zo
393
normal zo
395
normal zo
400
normal zo
402
normal zo
395
normal zo
393
normal zo
407
normal zo
409
normal zo
407
normal zo
414
normal zo
416
normal zo
422
normal zo
425
normal zo
426
normal zo
426
normal zo
426
normal zo
425
normal zo
429
normal zo
422
normal zo
414
normal zo
433
normal zo
435
normal zo
446
normal zo
448
normal zo
449
normal zo
449
normal zo
449
normal zo
448
normal zo
452
normal zo
446
normal zo
433
normal zo
457
normal zo
459
normal zo
460
normal zo
459
normal zo
457
normal zo
let s:l = 464 - ((25 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
464
normal! 0
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
