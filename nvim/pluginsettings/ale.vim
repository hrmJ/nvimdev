
let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'javascript.jsx': ['prettier', 'eslint'],
\   'python': ['yapf'],
\   'scss': ['prettier'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'javascript.jsx': ['eslint'],
\   'python': ['flake8', 'pylint'],
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_python_pylint_options = '--load-plugins pylint_django'

