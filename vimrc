" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
"Plugin 'tpope/vim-rails.git'	" for ruby on rails
"it can add }]' and so on automatically
Plugin 'jiangmiao/auto-pairs'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}		" useful when write html
" scripts from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Bundle 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'
" scripts not on GitHub
"Plugin 'git://git.wincent.com/command-t.git'	" need vim compiled with ruby support
"Bundle 'https://github.com/Lokaltog/vim-powerline.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Bundle 'https://github.com/scrooloose/nerdtree'
Bundle 'https://github.com/scrooloose/nerdcommenter'
Bundle 'https://github.com/nathanaelkane/vim-indent-guides'
Bundle 'https://github.com/terryma/vim-multiple-cursors'
"Bundle 'https://github.com/davidhalter/jedi-vim'		" very hard to use
"Bundle 'lrvick/Conque-Shell'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'

"模块补全
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"
"use for the nerdcommenter
let mapleader=','		" change default leader key
let s:kernel_release='Arch'
let s:username=$USER
let s:email=$WORK_EMAIL
let s:time_format='%F %a %R'
filetype plugin indent on     " required

map <F9> :call SaveInputData()<CR>
func! SaveInputData()
	exec "tabnew"
	exec 'normal "+gP'
	exec "w! /tmp/input_data"
endfunc

" 记录光标位置
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END


"colorscheme torte
"colorscheme murphy
"colorscheme desert  
"colorscheme elflord
"colorscheme ron

"colorscheme github
"colorscheme eclipse
"colorscheme solarized
colorscheme molokai

set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936	"fileencodings
set termencoding=utf-8
set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
"winpos 5 5          " 设定窗口位置  
"set lines=40 columns=155    " 设定窗口大小  
set go=             " 不要图形按钮  
"color asmanian2     " 设置背景主题  
"set guifont=Courier_New:h10:cANSI   " 设置字体  
syntax on       " 语法高亮  
filetype on
autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set showcmd         " 输入的命令显示出来，看的清楚些  
set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
"set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set novisualbell    " 不要闪烁
set background=dark "背景使用黑色	"各种主题都有亮色和暗色，light和dark
set guifont=DejaVu\ Sans\ Mono\ Book\ for\ Powline\ 11
:hi Folded ctermbg=240
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set the file type
"au BufRead,BufNewFile *.py set filetype=py
"au BufRead,BufNewFile *.h set filetype=h
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.c,*.h,*.sh,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#########################################################################") 
		call append(line("."), "\# File Name:\t\t".expand("%")) 
		call append(line(".")+1, "\# Author:\t\t".expand(s:username)) 
		call append(line(".")+2, "\# Mail:\t\t".expand(s:email)) 
		call append(line(".")+3, "\# Created Time\t: ".strftime(s:time_format)) 
		call append(line(".")+4, "\#########################################################################") 
		call append(line(".")+5, "\#!/bin/bash") 
		call append(line(".")+6, "") 
	elseif &filetype == 'python'
		call setline(1,"'''''''''''''''''''''''''''''''''''''''''''''''''''")
		call append(line("."), "  > System:\t\t".expand(s:kernel_release))
		call append(line(".")+1, "  > Author:\t\t".expand(s:username))
		call append(line(".")+2, "  > Mail:\t\t".expand(s:email))
		call append(line(".")+3,   "  > File Name:\t\t".split(expand("%"), '/')[-1])
		call append(line(".")+4, "  > Created Time:\t".strftime(s:time_format)) 
		call append(line(".")+5, "'''''''''''''''''''''''''''''''''''''''''''''''''''")
		call append(line(".")+6, "")
	else
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name:\t\t".expand("%")) 
		call append(line(".")+1, "	> Author:\t\t\t".expand(s:username)) 
		call append(line(".")+2, "	> Mail:\t\t\t\t".expand(s:email)) 
		call append(line(".")+3, "	> Created Time:\t\t".strftime(s:time_format)) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+5, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include <stdio.h>")
		call append(line(".")+7, "")
	elseif &filetype == 'cpp'
		call append(line(".")+6, "#include <iostream>")
		call append(line(".")+7, "")
		call append(line(".")+8, "")
	endif
	if &filetype == 'java'
		call append(line(".")+6, "public class ".expand("%:t:r"))
		call append(line(".")+7, "\{")
		call append(line(".")+8, "    public static void main\(String\[\] args\)\{")
		call append(line(".")+9, "		")
		call append(line(".")+10, "    \}")
		call append(line(".")+11, "\}")
		call cursor(11,8)
	else
		normal G
	endif
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:nnoremap <Leader>w <C-w>	" because ctrl-w conflict with chrome shortcut
nmap <leader>f :find<cr>

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y		" not work, don't know why
"去空行
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 
"新建标签  
map <M-F2> :tabnew<CR>  
"列出当前目录文件  
map <F3> :tabnew .<CR>  
"打开树状文件目录  
map <C-F3> \be  
nmap <leader>r :call Run()<CR>
func! Run()
	exec "w"
	if &filetype is 'c'
		exec "!clang % -o %<"
		exec "! ./%<"
	elseif &filetype is 'cpp'
		exec "!g++ -std=c++14 % -o %< -lpthread"
		exec "! ./%<"
	elseif &filetype is 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype is 'sh'
		:!bash %
	elseif &filetype is 'python'
		exec "!python3 %"
	elseif &filetype is 'lisp'
		exec "!sbcl < %"
	elseif &filetype is 'go'
		exec "GoRun %"
	elseif &filetype is 'rust'
		exec "!rustc %"
		exec "! ./%<"
	endif
endfunc
map <F10> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	if &filetype is 'c'
		exec "!clang % -g -o %<"
	elseif &filetype is 'cpp'
		exec "!g++ % -std=c++14 -g -o %<"
	exec "!gdb ./%<"
	endif
endfunc



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置当文件被改动时自动载入
set autoread

"{{ c, cpp quickfix
"make 运行
:set makeprg=gcc\ -Wall\ \ %
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
"}}
"

"clipboard: install vim version have +clipboard

"允许插件  
filetype plugin on
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺
set cursorline              " 高亮当前行
set cursorcolumn			" 高亮显示当前列
set magic                   " 设置魔术(basic regular expression)
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
set foldcolumn=0
set foldenable      " 允许启动vim时折叠  
set foldmethod=syntax   " better than indent
set foldlevel=3 
" 不要使用vi的键盘模式，而是vim自己的
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
set cindent
set smartindent
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 不要用空格代替制表符
set noexpandtab
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
" 历史记录数
set history=1000
"禁止生成临时文件
set nobackup
set noswapfile
"搜索逐字符高亮
set hlsearch
set incsearch
"默认一行仅替换一个改为一行替换所有
"set gdefault
"编码设置
set enc=utf-8
" file prefer encoding order
set fencs=utf-8,ucs-bom,utf-16le,utf16-be,default,shift-jis,gb18030,gbk,gb2312,cp936
"语言设置
set langmenu=en_US.UTF-8
set helplang=en
" 为特定文件类型载入相关缩进文件
filetype indent on
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 字符间插入的像素行数目
set linespace=0
" 增强模式中的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 设置进入paste模式的开关
nmap <leader>p :set invpaste paste?<CR>
"nnoremap <F3> :set invpaste paste?<CR>
"imap <F3> <C-O>:set invpaste paste?<CR>
"set pastetoggle=<F3>
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

"""""""""""""""""""""""""""""""""""""""
"              UltiSnips              "
"""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories=["mynew"]
" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader>b"

"""""""""""""""""""""""""""""""""""""""
"               NERDtee               "
"""""""""""""""""""""""""""""""""""""""
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$VIM.'/Data/NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=31
let NERDTreeIgnore=['__pycache__$', '\~$'] "ignore files in NERDTree
map <leader>cf :NERDTreeFind<cr>
"nnoremap f :NERDTreeToggle
map <F7> :NERDTree<CR>

"""""""""""""""""""""""""""""""""""""""
"            YouCompleteMe            "
"""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf=$HOME.'/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=1    "打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_collect_identifiers_from_tag_files = 0 "使用ctags生成的tags文件"
let g:ycm_error_symbol='>>'  "错误标志
let g:ycm_warning_symbol='>*'  "警告标志
"开启语义补全  
let g:ycm_seed_identifiers_with_syntax = 1  
"在接受补全后不分裂出一个窗口显示接受的项  
set completeopt-=preview  
"每次重新生成匹配项，禁止缓存匹配项  
let g:ycm_cache_omnifunc=0  
"在注释中也可以补全  
"let g:ycm_complete_in_comments=1  
""输入第一个字符就开始补全  
let g:ycm_min_num_of_chars_for_completion=1  
"不查询ultisnips提供的代码模板补全，如果需要，设置成1即可  
"let g:ycm_use_ultisnips_completer=0  
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_key_invoke_completion = ''
" python 解释器路径
let g:ycm_path_to_python_interpreter=$HOME.'/anaconda3/bin/python'
let g:ycm_server_python_interpreter=$HOME.'/anaconda3/bin/python'
" 字符中也开启补全
let g:ycm_complete_in_strings = 1

nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gd :YcmCompleter GetDoc<CR>
" in terminal fg color is purple, bg color is None
highlight Pmenu ctermfg=5 ctermbg=0 guifg=#ffffff guibg=#0000ff

"let g:loaded_youcompleteme = 1			" don't load ycm for python, use jedi instead

"""""""""""""""""""""""""""""""""""""""
"            indent-guides            "
"""""""""""""""""""""""""""""""""""""""
" 随 vim 自启动
 "let g:indent_guides_enable_on_vim_startup=1
" " 从第二层开始可视化显示缩进
 let g:indent_guides_start_level=2
" " 色块宽度
 let g:indent_guides_guide_size=1
" " 快捷键,v 开/关缩进可视化
 :nmap <silent> <Leader>v <Plug>IndentGuidesToggle"

"""""""""""""""""""""""""""""""""""""""
"  disable cursor keys in normal mode "
"""""""""""""""""""""""""""""""""""""""
 "map <Left>  :echo "no!"<cr>
 "map <Right> :echo "no!"<cr>
 "map <Up>    :echo "no!"<cr>
 "map <Down>  :echo "no!"<cr>

"""""""""""""""""""""""""""""""""""""""
"        vim-mutiple-cursors          "
"""""""""""""""""""""""""""""""""""""""
" vim mutiple cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<S-n>'
let g:multi_cursor_prev_key='<S-p>'
let g:multi_cursor_skip_key='<S-s>'
let g:multi_cursor_quit_key='<Esc>'

"""""""""""""""""""""""""""""""""""""""
"                ctrlp                "
"""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map='<leader>.'
let g:ctrlp_open_mutiple_files='v'	" 打开多个文件竖直分屏
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm|__pycache__)$',
    \ 'file': '\v\.(so|dll|pyc)$',
    \ }
"""""""""""""""""""""""""""""""""""""""
"            ctrlp-funky              "
"""""""""""""""""""""""""""""""""""""""
nnoremap <leader>.f :CtrlPFunky<Cr>
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1

"""""""""""""""""""""""""""""""""""""""
"				airline				  "
"""""""""""""""""""""""""""""""""""""""
let g:airline_theme="monochrome" "ubaryd, monochrome, raven, luna, simple, papercolor, lucius
"这个是安装字体后 必须设置此项
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_section_c = ''	" unset filename below(because it already have above)

"""""""""""""""""""""""""""""""""""""""
"              snippet                "
"""""""""""""""""""""""""""""""""""""""
let g:snips_author=$USER
let g:snips_email=$WORK_EMAIL
let g:snips_github='https://github.com/ltltlt'

"""""""""""""""""""""""""""""""""""""""
"			   rust.vim				  "
"""""""""""""""""""""""""""""""""""""""
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'xclip -selection clipboard'

"{{ Go
nmap <leader>gi :GoImports<cr>
nmap <leader>gd :GoDoc<cr>
"}}

"{{ disable stupid sql completion
let g:loaded_sql_completion = 0
let g:omni_sql_no_default_maps = 1
"}}
