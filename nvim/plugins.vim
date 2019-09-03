
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'



" python dev
" Plugin 'davidhalter/jedi-vim'
" Plugin 'nvie/vim-flake8'
" Plugin 'JarrodCTaylor/vim-python-test-runner'
" Plugin 'heavenshell/vim-pydocstring'
" Plugin 'tweekmonster/django-plus.vim'


" file navigation 
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" moving / typing

Plugin 'justinmk/vim-sneak' " (map s to 2-char quick search)
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate' " (Automatically close brackets etc)
Plugin 'easymotion/vim-easymotion'

" search 

Plugin 'vim-scripts/sherlock.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'wincent/ferret'

" javascript / webdev

Plugin 'neoclide/coc.nvim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'Galooshi/vim-import-js'
Plugin 'mattn/emmet-vim'
Plugin 'janko/vim-test'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'heavenshell/vim-jsdoc'

" vim's look  and interface

Plugin 'vim-airline/vim-airline'
Plugin 'tomasiser/vim-code-dark'
Plugin 'mhartington/oceanic-next'
Plugin 'arcticicestudio/nord-vim'


" writing

Plugin 'vim-voom/VOoM'
Plugin 'junegunn/goyo.vim'
Plugin 'dhruvasagar/vim-table-mode'

" git:
Plugin 'tpope/vim-fugitive'
" r
Plugin 'jalvesaq/Nvim-R'


" Other / system

Plugin 'skywind3000/asyncrun.vim'
Plugin 'mhinz/vim-signify'
Plugin 'chamindra/marvim' " (Saving macros)


call vundle#end()          
filetype plugin indent on  
