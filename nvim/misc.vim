" save when leaving insert mode
autocmd InsertLeave * write
" Don't show last command
set noshowcmd
" Hides buffers instead of closing them
set hidden
" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab
" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2
" Indentation amount for < and > commands.
set shiftwidth=2
" do not wrap long lines by default
set nowrap
" Don't highlight current cursor line
set nocursorline
" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler
" Only one line for command line
set cmdheight=1
" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c

" Reload icons after init source
" if exists('g:loaded_webdevicons')
"   call webdevicons#refresh()
" endif
