Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'tom-anders/telescope-vim-bookmarks.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
" Plug 'nvim-telescope/telescope-repo.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-telescope/telescope-file-browser.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'nvim-telescope/telescope-z.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
call plug#end()

lua << EOF
require'telescope'.load_extension('project')
require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    file_browser = {
      -- theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
     project = {
      base_dirs = {
        '~/Desktop/Work',
        -- {'~/'},
        -- {'~/dev/src3', max_depth = 4},
        -- {path = '~/dev/src4'},
        -- {path = '~/dev/src5', max_depth = 2},
      },
      hidden_files = true, -- default: false
      theme = "dropdown"
  },
  ["ui-select"] = {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"
require("telescope").load_extension "fzf"
require'telescope'.load_extension'z'
-- require("telescope").load_extension "repo"
-- require('telescope').load_extension('fzf')
EOF
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope fd<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>

" Help
nnoremap <leader>ho :Telescope help_tags<CR>
nnoremap <leader>hk :Telescope keymaps<CR>

" Find
nmap <Leader>fb :Telescope vim_bookmarks all<CR>
nmap <Leader>fr :Telescope oldfiles<CR>
nmap <Leader>fd :Dashboard<CR>

" Bookmark
nmap <Leader>fB :Telescope vim_bookmarks all<CR>

" Buffer
nmap <Leader>bb :Telescope buffers<CR>
nmap <Leader>bd :bd<CR>
nmap <Leader>bn :bnext<CR>
nmap <Leader>bp :bprev<CR>
nmap <Leader>bl :bnext<CR>
nmap <Leader>bh :bprev<CR>
nmap <Leader>gb :Telescope git_branches<CR>


" Commands
nmap <Leader>; :Telescope commands<CR>
"

" Reloads
nmap <Leader>rr :source ~/.config/nvim/init.vim<CR>
nmap <Leader>rR :source %<CR>

" nnoremap <Leader>ff :lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy({}))<cr>
"
nnoremap <Leader>bg :lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>

" Projects
nnoremap <Leader>mm :Telescope project<CR>
