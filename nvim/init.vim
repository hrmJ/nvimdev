set nocompatible              " be iMproved, required
filetype off                  " required
"Escape from terminal by ESC
tnoremap <Esc> <C-\><C-n>
set wildignore+=*/node_modules/**,*.swp,*.zip,*/__pycache__/**,*/dist/**

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/keys.vim
source $HOME/.config/nvim/filetypes.vim
source $HOME/.config/nvim/generalsettings.vim
source $HOME/.config/nvim/misc.vim

source $HOME/.config/nvim/pluginsettings/ultisnips.vim
source $HOME/.config/nvim/pluginsettings/jsdoc.vim
source $HOME/.config/nvim/pluginsettings/ale.vim
source $HOME/.config/nvim/pluginsettings/vim-test.vim
"source $HOME/.config/nvim/pluginsettings/denite.vim
source $HOME/.config/nvim/pluginsettings/coc.vim
source $HOME/.config/nvim/pluginsettings/nerdtree.vim
source $HOME/.config/nvim/pluginsettings/airline.vim
source $HOME/.config/nvim/pluginsettings/vim-javascript.vim
" source $HOME/.config/nvim/pluginsettings/neosnippet.vim
" source $HOME/.config/nvim/pluginsettings/neosnippet.vim



" source $HOME/.config/nvim/themes/jarvis.vim
" source $HOME/.config/nvim/themes/nord.vim
source $HOME/.config/nvim/themes/codedark.vim
" source $HOME/.config/nvim/themes/transparent.vim
