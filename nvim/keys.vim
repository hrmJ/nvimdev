
" Remap leader key to ,
let g:mapleader=','

noremap <C-s> :update<CR>

imap <C-l> <Plug>(coc-snippets-expand)

" testing

nmap <silent> t<C-n> :silent! TestNearest<CR>
nmap <silent> t<C-f> :silent! TestFile<CR>
nmap <silent> t<C-s> :silent! TestSuite<CR>
nmap <silent> t<C-l> :silent! TestLast<CR>
nmap <silent> t<C-g> :silent! TestVisit<CR>

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>l :Lines<CR>

" https://github.com/ctaylo21/jarvis/blob/master/config/nvim/init.vim
" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and
"   close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap <leader>db :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>t :Denite file/rec -split=floating -winrow=1<CR>
" nnoremap <leader>j :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <leader>n :NERDTreeToggle<CR>
" nmap <leader>f :NERDTreeFind<CR>

"   <Space> - PageDown
"   -       - PageUp
" noremap <Space> <PageDown>
" noremap - <PageUp>

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" === Search shorcuts === "
"   <leader>h - Find and replace
"   <leader>/ - Claer highlighted search terms while preserving history
" map <leader>h :%s///<left><left>
nmap <silent> <leader>/ :nohlsearch<CR>

" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>w <Plug>(easymotion-bd-w)

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP
