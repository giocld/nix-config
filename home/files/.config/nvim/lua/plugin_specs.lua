local utils = require("utils")

local plugin_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
local lazypath = vim.fs.joinpath(plugin_dir, "lazy.nvim")

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- check if firenvim is active
local firenvim_not_active = function()
  return not vim.g.started_by_firenvim
end

local plugin_specs = {
  -- auto-completion engine
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    config = function()
      require("config.blink-cmp")
    end,
    opts_extend = { "sources.default" },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.lsp")
    end,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      require("config.glance")
    end,
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    branch = "main",
    config = function()
      require("config.treesitter-textobjects")
    end,
  },
  { "machakann/vim-swap", event = "VeryLazy" },

  -- Super fast buffer jump
  {
    "smoka7/hop.nvim",
    keys = { "f" },
    config = function()
      require("config.nvim_hop")
    end,
  },

  -- Show match number and index for searching
  {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { "*", "#", "n", "N" },
    config = function()
      require("config.hlslens")
    end,
  },

  {
    "ibhagwan/fzf-lua",
    config = function()
      require("config.fzf-lua")
    end,
    event = "VeryLazy",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    main = "render-markdown",
    opts = {},
    ft = { "markdown" },
  },
  -- A list of colorscheme plugin you may want to try. Find what suits you.
  { "vague2k/vague.nvim", priority = 1000 },

  -- plugins to provide nerdfont icons
  {
    "nvim-mini/mini.icons",
    version = false,
    config = function()
      -- this is the compatibility fix for plugins that only support nvim-web-devicons
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons()
      require("mini.icons").tweak_lsp_kind()
    end,
    lazy = false,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    cond = firenvim_not_active,
    config = function()
      require("config.lualine")
    end,
  },

  {
    "akinsho/bufferline.nvim",
    event = { "BufEnter" },
    cond = firenvim_not_active,
    config = function()
      require("config.bufferline")
    end,
  },

  -- fancy start screen
  {
    "goolord/alpha-nvim",
    cond = firenvim_not_active,
    config = function()
      require("config.alpha-nvim")
    end,
  },

  {
    "nvim-mini/mini.indentscope",
    version = false,
    config = function()
      local mini_indent = require("mini.indentscope")
      mini_indent.setup {
        draw = {
          animation = mini_indent.gen_animation.none(),
        },
        symbol = "▏",
      }
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    opts = {},
    config = function()
      require("config.nvim-statuscol")
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function ()
      require("toggleterm").setup({
        size = 10,
        open_mapping = [[<leader>t]],
        direction = "horizontal",
        shade_terminals = true,
        on_open = function(term)
          local dir = vim.fs.root(0, { ".git", ".hg", ".svn" }) or vim.fn.expand("%:p:h")
          if dir and vim.fn.isdirectory(dir) == 1 then
            term:change_dir(dir)
          end
        end,
      })
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("config.nvim_ufo")
    end,
  },
  -- Highlight URLs inside vim
  { "itchyny/vim-highlighturl", event = "BufReadPost" },

  -- notification plugin
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("config.nvim-notify")
    end,
  },

  { "nvim-lua/plenary.nvim", lazy = true },

  -- Automatic insertion and deletion of a pair of characters
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Comment plugin
  {
    "tpope/vim-commentary",
    keys = {
      { "gc", mode = "n" },
      { "gc", mode = "v" },
    },
  },

  -- Multiple cursor plugin like Sublime Text?
  -- 'mg979/vim-visual-multi'

  -- Manage your yank history
  {
    "gbprod/yanky.nvim",
    config = function()
      require("config.yanky")
    end,
    cmd = "YankyRingHistory",
  },

  -- Handy unix command inside Vim (Rename, Move etc.)

  { "tpope/vim-eunuch", cmd = { "Rename", "Delete" } },

  -- Repeat vim motions
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "nvim-zh/better-escape.vim",
    init = function()
      vim.cmd([[
      let g:better_escape_interval = 100
    ]])
    end,
    event = { "InsertEnter" },
  },

  -- Git command inside vim
  {
    "tpope/vim-fugitive",
    event = "User InGitRepo",
    config = function()
      require("config.fugitive")
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      -- Only one of these is needed.
      "ibhagwan/fzf-lua", -- optional
    },
    event = "User InGitRepo",
  },

  -- Better git log display
  { "rbong/vim-flog", cmd = { "Flog" } },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("config.git-conflict")
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    event = "User InGitRepo",
    config = function()
      require("config.git-linker")
    end,
  },

  -- Show git change (change, delete, add) signs in vim sign column
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
    event = "BufRead",
    version = "*",
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen" },
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("config.bqf")
    end,
  },

  -- Faster footnote generation
  { "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } },

  -- Vim tabular plugin for manipulate tabular, required by markdown plugins
  { "godlygeek/tabular", ft = { "markdown" } },

  {
    "chrisbra/unicode.vim",
    init = function()
      vim.cmd([[
        nmap ga <Plug>(UnicodeGA)
      ]])
    end,
    event = "VeryLazy",
  },

  -- Additional powerful text object for vim, this plugin should be studied
  -- carefully to use its full power
  { "wellle/targets.vim", event = "VeryLazy" },

  -- Plugin to manipulate character pairs quickly
  {
    "machakann/vim-sandwich",
    init = function()
      vim.cmd([[
        " Map s to nop since s in used by vim-sandwich. Use cl instead of s.
        nmap s <Nop>
        omap s <Nop>
      ]])
    end,
    event = "VeryLazy",
  },

  -- Only use these plugin on Windows and Mac and when LaTeX is installed
  {
    "lervag/vimtex",
    init = function()
      vim.cmd([[
        if executable('latex')
          " Hacks for inverse search to work semi-automatically,
          function! s:write_server_name() abort
            let nvim_server_file = (has('win32') ? $TEMP : '/tmp') . '/vimtexserver.txt'
            call writefile([v:servername], nvim_server_file)
          endfunction

          augroup vimtex_common
            autocmd!
            autocmd FileType tex call s:write_server_name()
            autocmd FileType tex nmap <buffer> <F9> <plug>(vimtex-compile)
          augroup END

          let g:vimtex_compiler_latexmk = {
                \ 'build_dir' : 'build',
                \ }

          " TOC settings
          let g:vimtex_toc_config = {
                \ 'name' : 'TOC',
                \ 'layers' : ['content', 'todo', 'include'],
                \ 'resize' : 1,
                \ 'split_width' : 30,
                \ 'todo_sorted' : 0,
                \ 'show_help' : 1,
                \ 'show_numbers' : 1,
                \ 'mode' : 2,
                \ }

          " Viewer settings for different platforms
          if g:is_win
            let g:vimtex_view_general_viewer = 'SumatraPDF'
            let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
          endif

          if g:is_mac
            " let g:vimtex_view_method = "skim"
            let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
            let g:vimtex_view_general_options = '-r @line @pdf @tex'

            augroup vimtex_mac
              autocmd!
              autocmd User VimtexEventCompileSuccess call UpdateSkim()
            augroup END

            " The following code is adapted from https://gist.github.com/skulumani/7ea00478c63193a832a6d3f2e661a536.
            function! UpdateSkim() abort
              let l:out = b:vimtex.out()
              let l:src_file_path = expand('%:p')
              let l:cmd = [g:vimtex_view_general_viewer, '-r']

              if !empty(system('pgrep Skim'))
                call extend(l:cmd, ['-g'])
              endif

              call jobstart(l:cmd + [line('.'), l:out, l:src_file_path])
            endfunction
          endif
        endif
      ]])
    end,
    enabled = function()
      return utils.executable("latex")
    end,
    ft = { "tex" },
  },

  -- Since tmux is only available on Linux and Mac, we only enable these plugins
  -- for Linux and Mac
  -- .tmux.conf syntax highlighting and setting check
  {
    "tmux-plugins/vim-tmux",
    enabled = function()
      return utils.executable("tmux")
    end,
    ft = { "tmux" },
  },

  -- Modern matchit implementation
  {
    "andymass/vim-matchup",
    init = function()
      vim.cmd([[
        " Improve performance
        let g:matchup_matchparen_deferred = 1
        let g:matchup_matchparen_timeout = 100
        let g:matchup_matchparen_insert_timeout = 30

        " Enhanced matching with matchup plugin
        let g:matchup_override_vimtex = 1

        " Whether to enable matching inside comment or string
        let g:matchup_delim_noskips = 0

        " Show offscreen match pair in popup window
        let g:matchup_matchparen_offscreen = {'method': 'popup'}
    ]])
    end,
    event = "BufRead",
  },
  { "tpope/vim-scriptease", cmd = { "Scriptnames", "Messages", "Verbose" } },

  { "cespare/vim-toml", ft = { "toml" }, branch = "main" },

  -- Session management plugin
  { "tpope/vim-obsession", cmd = "Obsession" },

  -- showing keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("config.which-key")
    end,
  },
  {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    input = {
      enabled = true,
      win = {
        relative = "cursor",
        backdrop = true,
      },
    },
    picker = {
      enabled = true,
      actions = {
        opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
      },
      win = {
        input = {
          keys = {
            ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
          },
        },
      },
    },
    terminal = {}, -- Enables the snacks provider for opencode
  },
},

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    keys = { "<space>s" },
    config = function()
      require("config.nvim-tree")
    end,
  },

  {
    "j-hui/fidget.nvim",
    event = "BufRead",
    config = function()
      require("config.fidget-nvim")
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
  "nickjvandyke/opencode.nvim",
  version = "*",
  config = function()
    local opencode_cmd = "opencode --port"
    ---@type snacks.terminal.Opts
    local snacks_terminal_opts = {
      win = {
        position = "right",
        width = 0.35,
        enter = true,
        on_win = function(win)
          require("opencode.terminal").setup(win.win)
        end,
      },
    }
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Just add this 'server' section
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, snacks_terminal_opts)
        end,
        stop = function()
          local term = require("snacks.terminal").get(opencode_cmd, snacks_terminal_opts)
          if term then
            term:close()
          end
        end,
        toggle = function()
          require("snacks.terminal").toggle(opencode_cmd, snacks_terminal_opts)
        end,
      },
    }
    vim.o.autoread = true -- Required for opts.events.reload
  end,
  keys = {
    { "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode..." },
    { "<leader>ox", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Execute opencode action..." },
    { "<leader>ot", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode" },
    { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, desc = "Add range to opencode", expr = true },
    { "goo", function() return require("opencode").operator("@this ") .. "_" end, mode = "n", desc = "Add line to opencode", expr = true },
  },
},

{
    "cousine/opencode-context.nvim",
    opts = {
      auto_detect_pane = true,
    },
    keys = {
      { "<leader>os", "<cmd>OpencodeSend<cr>", desc = "Sync buffer to OpenCode" },
      { "<leader>os", "<cmd>OpencodeSend<cr>", mode = "v", desc = "Sync selection to OpenCode" },
    }
},
  {
    "smjonas/live-command.nvim",
    -- live-command supports semantic versioning via Git tags
    -- tag = "2.*",
    event = "VeryLazy",
    config = function()
      require("config.live-command")
    end,
  },
  {
    -- show hint for code actions, the user can also implement code actions themselves,
    -- see discussion here: https://github.com/neovim/neovim/issues/14869
    "kosayoda/nvim-lightbulb",
    config = function()
      require("config.lightbulb")
    end,
    event = "LspAttach",
  },
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5.0.0",
    ft = "rust",
    config = function()
      require("config.rust-tools")
    end,
  },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    config = function ()
      require("config.crates")
    end,

  },
  {
    "supermaven-inc/supermaven-nvim",
    event = "VeryLazy",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<C-e>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      }
    end,
  },
}

require("lazy").setup {
  spec = plugin_specs,
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
  rocks = {
    enabled = false,
    hererocks = false,
  },
}

-- Use short names for common plugin manager commands to simplify typing.
-- To use these shortcuts: first activate command line with `:`, then input the
-- short alias, e.g., `pi`, then press <space>, the alias will be expanded to
-- the full command automatically.
vim.fn["utils#Cabbrev"]("pi", "Lazy install")
vim.fn["utils#Cabbrev"]("pud", "Lazy update")
vim.fn["utils#Cabbrev"]("pc", "Lazy clean")
vim.fn["utils#Cabbrev"]("ps", "Lazy sync")
