"                                 ___     
"        ___        ___          /__/\    
"       /__/\      /  /\        |  |::\   
"       \  \:\    /  /:/        |  |:|:\  
"        \  \:\  /__/::\      __|__|:|\:\ 
"    ___  \__\:\ \__\/\:\__  /__/::::| \:\
        "   /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/
        "   \  \:\|  |:|     \__\::/  \  \:\      
        "    \  \:\__|:|     /__/:/    \  \:\     
        "     \__\::::/      \__\/      \  \:\    
        "         ~~~~                   \__\/    

        " Set compatibility to Vim only.
        set nocompatible

        "Always show current position
        set ruler

        " Turn on syntax highlighting.
        syntax on

        " Turn off modelines
        set modelines=0

        " Uncomment below to set the max textwidth. Use a value corresponding to the width of your screen.
        " set textwidth=80
        set formatoptions=tcqrn1
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set expandtab
        set noshiftround

        " Ignore case when searching
        set ignorecase

        " When searching try to be smart about cases 
        set smartcase

        " Don't redraw while executing macros (good performance config)
        set lazyredraw

        " For regular expressions turn magic on
        set magic

        " Display 5 lines above/below the cursor when scrolling with a mouse.
        set scrolloff=5
        " Fixes common backspace problems
        set backspace=indent,eol,start

        " Display options
        set showmode
        set showcmd
set cmdheight=1

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
"set list
"set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number
highlight LineNr ctermfg=red

" Set highlight color
hi Search cterm=NONE ctermfg=black ctermbg=blue


" Set status line display
set laststatus=2
hi StatusLine ctermfg=black ctermbg=green cterm=NONE
hi StatusLineNC ctermfg=black ctermbg=magenta cterm=NONE
hi User1 ctermfg=black ctermbg=magenta
hi User2 ctermfg=NONE ctermbg=NONE
hi User3 ctermfg=black ctermbg=blue
hi User4 ctermfg=black ctermbg=cyan
hi User5 ctermfg=black ctermbg=yellow
hi User6 ctermfg=black ctermbg=red
set statusline=\                    " Padding
set statusline+=%f                  " Path to the file
set statusline+=\ %1*\              " Padding & switch colour
set statusline+=%y                  " File type
set statusline+=\ %2*\              " Padding & switch colour
set statusline+=%=                  " Switch to right-side
set statusline+=\ %3*\              " Padding & switch colour
set statusline+=line                " of Text
set statusline+=\                   " Padding
set statusline+=%l                  " Current line
set statusline+=\ %4*\              " Padding & switch colour
set statusline+=of                  " of Text
set statusline+=\                   " Padding
set statusline+=%L                  " Total line
set statusline+=\ 

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch

" Enable incremental search
set incsearch

" Include matching uppercase words with lowercase search term
set ignorecase

" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

set noerrorbells visualbell t_vb=
autocmd FileType rmd setlocal nonumber
autocmd FileType md setlocal nonumber
autocmd FileType txt setlocal nonumber
autocmd FileType tex setlocal nonumber

" configure weird key shortcuts

execute "set <F13>=\e[25~"
imap <F13> <esc>O

execute "set <F14>=\e[26~"
imap <F14> <esc>diwi

execute "set <F15>=\e[27~"
imap <F15> <esc>V

execute "set <F16>=\e[28~"
imap <F16> <esc>pi


execute "set <F17>=\e[29~"
imap <F17> <esc>ggi

execute "set <F18>=\e[30~"
imap <F18> <esc>:w <CR>i

" Writes the current file to ~/Documents/.bkup/ every 60 seconds and removes oldest backups
function BackupConfig()
    set updatetime=60000
    let bkupdir = ($HOME) . '/Documents/.bkup/' . expand('%:p:h:t') . '/' . expand('%:t')
    silent call system('mkdir -p ' . bkupdir)
    au! CursorHold,CursorHoldI * execute ':w! ' . ($HOME) . '/Documents/.bkup/' . expand('%:p:h:t') . '/' . expand('%:t') . '/' . strftime("(%y%m%d)[%Hh%M]")
    silent call system('bkclean ' . bkupdir)
endfunction


" Grab wordcount per paragraph


function WordCountParagraph()
    let line1 = line("'{")
    let line2 = line("'}")
    execute "return len(split(join(getline(" . line1 . "," . line2 . "), ' '), '\\s\\+'))"
endfunction


" call WordCountParagraph()

" Autosave and wordcount for Markdown files
function RmdConfig()
    call BackupConfig()
    set statusline+=\ %5*\              " Padding & switch colour
    set statusline+=\words\ %{WordCountParagraph()}
    set statusline+=\ %6*
    set statusline+=\ of\ %{wordcount().words}\ " Word Count
    set statusline-=\ 
    set tw=80
    set fo+=a
    set spell
endfunction 

" set persistent undo
    set undofile
    set undodir=$HOME/Documents/.bkup/undo
    set undolevels=1000         " How many undos
    set undoreload=10000        " number of lines to save for undo

autocmd FileType rmd call RmdConfig()
autocmd FileType md call RmdConfig() 

" Super easy keybinds for use in container
" map CTRL-s to end-of-line (insert mode)
imap <C-s> <esc>$i<right>
" map CTRL-h to beginning-of-line (insert mode)
imap <C-h> <esc>0i
" map CTRL-o to newline
imap <C-o> <esc>o
" map CTRL-t to down line
imap <C-t> <esc>ji
" map CTRL-n to up line
imap <C-n> <esc>ki
" map CTRL-d to delete current line
imap <C-d> <esc>ddi
" map CTRL-u to move to next word
imap <C-u> <C-\><C-O>e<esc>lli
" map CTRL-a to move to previous word
imap <C-a> <esc>bi
" map CTRL-z to undo
imap <C-z> <esc>ui
map <C-z> <esc>ui
" map CTRL-g to goto bottom
imap <C-g> <esc>Gi
" map CTRL-Backspace to delete last sentence
inoremap <C-Bs> <esc>v(di
