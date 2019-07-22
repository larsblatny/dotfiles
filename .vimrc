call plug#begin('~/.vim/plugged')
Plug '~/my-prototype-plugin' " Unmanaged plugin (manually installed and updated)

Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " Group dependencies, vim-snippets depends on ultisnips
Plug 'scrooloose/nerdtree' , { 'on': 'NERDTreeToggle' } " On-demand loading
Plug 'Xuyuanp/nerdtree-git-plugin' , { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' } " Using a non-master branch
" Plug 'fatih/vim-go', { 'tag': '*' } " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' } " Plugin options
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary' " auto-commenting
Plug 'tpope/vim-sleuth' " indentation
Plug 'Valloric/YouCompleteMe', { 'dir': '~/.vim/plugged/YouCompleteMe', 'do': 'python3 install.py --clang-completer' } " auto-complete
Plug 'tpope/vim-fugitive' " git
Plug 'airblade/vim-gitgutter' " git
Plug 'lervag/vimtex' " TeX
Plug 'ludovicchabant/vim-gutentags' " tags
Plug 'yegappan/greplace' " search and replace across multiple files
Plug 'ervandew/supertab' " Prevent tab comflict betwen ultisnips and YCM
Plug 'christoomey/vim-tmux-navigator'
" Plug 'Chiel92/vim-autoformat' " auto-formatting
" Plug 'Yggdroot/indentLine'
Plug 'xuhdev/vim-latex-live-preview' " A Vim Plugin for Lively Previewing LaTeX PDF Output
Plug 'skywind3000/asyncrun.vim'
call plug#end() " Add plugins to &runtimepath

filetype plugin indent on
syntax on " syntax highlighting

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

autocmd FileType tex inoremap \ '
autocmd FileType tex inoremap ' \
nnoremap <CR> :
vnoremap <CR> :
nnoremap <C-f> :FZF<CR>
nnoremap [ :GitGutterPrevHunk<CR>
nnoremap ] :GitGutterNextHunk<CR>
nnoremap <Bar> :GitGutterStageHunk<CR>
nnoremap ww :w<CR>

set backspace=indent,eol,start " enable backspace

set mouse=a " enable mouse
if !has('nvim')
    set ttymouse=xterm2 " enable mouse in vim in tmux
else
    " asyncrun settings (since they are only available in nvim)
    nnoremap <C-s> :AsyncRun make -j 48<CR>
    let g:asyncrun_open=8
endif

set hlsearch " hightlight search result
set incsearch " incremental search
set showmatch " jump to matches when entering regexp
set ignorecase " ignore case when searching
set smartcase " no ignorecase if Uppercase char present

set scrolljump=5 " minimal number of lines to scroll when the cursor gets off the screen

set tabstop=4

" highlight Normal ctermfg=grey ctermbg=black
so ~/pps/Tomorrow-Night.vim

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" (La)TeX settings
let g:tex_flavor="latex" " this enables snippets for .tex file
let g:tex_indent_brace=0 " this prevents crazy indentation!
autocmd Filetype tex setlocal expandtab " this prevents crazy indentation
let g:Tex_ViewRule_pdf="Skim"
let g:vimtex_latexmk_callback = 1
let g:vimtex_latexmk_continuous = 1 
let g:vimtex_quickfix_ignore_all_warnings=0 
" let g:vimtex_quickfix_ignored_warnings = [ \Underfull\, \Overfull\, \specifier changed to\,] 
let g:vimtex_quickfix=2 
let g:vimtex_fold_automatic=0 
let g:Tex_DefaultTargetFormat = 'pdf'
 
let g:Tex_CompileRule_dvi = 'latex --interaction=nonstopmode $*'
let g:Tex_CompileRule_ps = 'dvips -Pwww -o $*.ps $*.dvi'
let g:Tex_CompileRule_pspdf = 'ps2pdf $*.ps'
let g:Tex_CompileRule_dvipdf = 'dvipdfm $*.dvi'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 --interaction=nonstopmode $*'
 
let g:Tex_ViewRule_dvi = 'texniscope'
let g:Tex_ViewRule_ps = 'Preview'
let g:Tex_ViewRule_pdf = 'open -a Skim'
let g:vimtex_view_general_viewer = 'open'
let g:vimtex_view_general_options = '-a Skim'
 
let g:Tex_FormatDependency_ps  = 'dvi,ps'
let g:Tex_FormatDependency_pspdf = 'dvi,ps,pspdf'
let g:Tex_FormatDependency_dvipdf = 'dvi,dvipdf'
 
" let g:Tex_IgnoredWarnings ='
"       \"Underfull'n".
"       \"Overfull'n".
"       \"specifier changed to'n".
"       \"You have requested'n".
"       \"Missing number, treated as zero.'n".
"       \"There were undefined references'n".
"       \"Citation %.%# undefined'n".
"       \"'oval, 'circle, or 'line size unavailable'n"' 

" Enable spelling check for .tex and .md files
autocmd FileType tex setlocal spell spelllang=en_us
autocmd FileType tex setlocal mousemodel=popup
autocmd FileType tex setlocal dictionary=/usr/share/dict/words
autocmd FileType md setlocal spell spelllang=en_us
autocmd FileType md setlocal mousemodel=popup
autocmd FileType md setlocal  dictionary=/usr/share/dict/words

" YCM settings
let g:ycm_confirm_extra_conf = 0 " disable checking extra_conf everytime
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" commentary settings
autocmd FileType cpp setlocal commentstring=//\ %s

" Cscope settings
map [I :cs find c <C-r><C-w><CR>
set csto=1


" vim-easy-align settings
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" NerdTree settings
let NERDTreeIgnore = ['\.o$']
map :NTT :NERDTreeToggle
" close vim if the only window left is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.	a:extension .'$#'
endfunction
call NERDTreeHighlightFile('lua', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('cpp', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('h', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('pynb', 'blue', 'none', 'blue', '#151515')

" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow','#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

filetype plugin indent on
