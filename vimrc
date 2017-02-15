set nocompatible
let b:did_ftplugin = 1
syntax on

"Assorted Settings."
set background=light t_Co=16
set backspace=2
set complete+=,]
set history=100
set hlsearch incsearch ignorecase smartcase
set laststatus=2 ruler
set listchars=trail:~,tab:>.
set modeline
set mouse=
set nrformats+=alpha
set showmatch matchpairs+=<:>
set wildmode=longest,list
set winaltkeys=no

"Indentation."
set autoindent
autocmd BufLeave * set expandtab shiftwidth=4 softtabstop=4
autocmd BufEnter Makefile* set noexpandtab shiftwidth=8 softtabstop=8
doautocmd BufLeave
map <Leader>2 :set   expandtab shiftwidth=2 softtabstop=2<CR>
map <Leader>4 :set   expandtab shiftwidth=4 softtabstop=4<CR>
map <Leader>8 :set noexpandtab shiftwidth=8 softtabstop=8<CR>

"Spell check."
if has("spell")
    set spelllang=en_ca spellfile=~/.spell.utf8.add
    if filereadable(expand("%:p:h")."/.spellfile.add")
        exe "setlocal spellfile=".expand("%:p:h")."/.spellfile.add"
    endif
    set spellcapcheck=$^
    highlight clear SpellCap
    autocmd BufLeave * set nospell
    autocmd BufEnter *.html,*.md,*.tex set spell
endif

"Better PageUp and PageDown."
map    <PageUp> <C-U>
imap   <PageUp> <Esc><C-U>i
map  <PageDown> <C-D>
imap <PageDown> <Esc><C-D>i

"Function Key Commands."
map  <F1> <Esc>
imap <F1> <Esc>
map  <F8> :set invpaste<CR>
imap <F8> <Esc>:set invpaste<CR>i
map  <F9> :set invspell<CR>
map <F11> :bprev<CR>
map <F12> :bnext<CR>

"Leader commands."
map  <Leader>f mz{V}!fmt -w70<CR>'z
vmap <Leader>f !fmt -w70<CR>
vmap <Leader>s !sort<CR>
map  <Leader>W :%s/\s\+$//<CR>
map  <Leader>/ :let @/ = ""<CR>

"Syntax."
function OnSyntax()
    syntax sync fromstart
    if &syntax == "tex"
        syntax cluster texCmdGroup add=@Spell
    endif
    hi link confString Normal
endf
autocmd Syntax * call OnSyntax()
autocmd BufEnter COMMIT_EDITMSG set syntax=diff
map <Leader>r :syntax off<CR>:syntax on<CR>:call OnSyntax()<CR>

"Local settings."
if filereadable(glob("~/.vimlocal"))
    source ~/.vimlocal
endif
