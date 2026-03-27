---------------------------------------------------------------
-- УСТАНОВКА LAZY (менеджер плагинов)
---------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

---------------------------------------------------------------
-- УСТАНОВКА ПЛАГИНОВ
---------------------------------------------------------------
--#############################################################
--#############################################################

require("lazy").setup({
	{"neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "texlab" } -- texlab хорош для LaTeX
    })

    local lspconfig = require("lspconfig")
    -- Настройка конкретного сервера
    lspconfig.lua_ls.setup({})
    lspconfig.texlab.setup({}) -- для работы с вашим VimTeX
  end
},
---------------------------------------------------------------
	{"hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- Источник: LSP
    "hrsh7th/cmp-buffer",       -- Источник: текст в текущем файле
    "hrsh7th/cmp-path",         -- Источник: пути в системе
    "L3MON4D3/LuaSnip",         -- Движок сниппетов (обязателен)
    "saadparwaiz1/cmp_luasnip", -- Связка cmp и luasnip
  },
  config = function()
    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter подтверждает выбор
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })
  end
},
---------------------------------------------------------------
	{"nvim-lua/plenary.nvim"},
---------------------------------------------------------------
	{"nvim-telescope/telescope.nvim",
	dependencies = {
    { 
        "nvim-telescope/telescope-live-grep-args.nvim" ,
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
--        version = "^1.0.0",
    },
  },
  config = function()
    local telescope = require("telescope")

    -- first setup telescope
    telescope.setup()
    -- then load the extension
    telescope.load_extension("live_grep_args")
    end
},
------------------------------------------------------------------
  	{"nvim-treesitter/nvim-treesitter", 
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
   	   	-- Список языков для установки
      		ensure_installed = { "lua", "vim", "vimdoc", "python", "powershell", "latex"},
      		-- Автоматическая установка при открытии нового типа файла
      		auto_install = true,
     		 highlight = {
      		  enable = true, -- Включить улучшенную подсветку
      			},
		      indent = {
       		 enable = true, -- Включить умные отступы
      		},
    		})
 	 end,
  	},
	  {"lervag/vimtex",
	lazy = false,
	init = function()
		vim.g.tex_flavor="latex"
	end
},
---------------------------------------------------------------------
	  {"ryanoasis/vim-devicons"},
---------------------------------------------------------------------
  	{"romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
    },
--    version = '^1.9.1', -- optional: only update when a new 1.x version is released
  },
		{"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Recommended
    "MunifTanjim/nui.nvim",
		 },
			config = function ()
			require'neo-tree'.setup({
			 filesystem = {
				commands = {
				system_open = function(state)
        local node = state.tree:get_node()
        local path = node.path
        -- Для Windows используем 'start', для Mac 'open', для Linux 'xdg-open'
        if vim.fn.has("win32") == 1 then
          vim.fn.jobstart({ "cmd.exe", "/c", "start", '""', path }, { detach = true })
        elseif vim.fn.has("mac") == 1 then
          vim.fn.jobstart({ "open", path }, { detach = true })
        else
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        end
				end,
					},
        window = {
            mappings = {
                -- Use 'O' to open with the system application
                ["O"] = "system_open",
                -- 'enter' or 'cr' will open in a Neovim buffer (default behavior)
                ["<CR>"] = "open",
							  -- disable fuzzy finder
								["/"] = "noop",
            },
        },
    },
			})
			end,
		},
------------------------------------------------------------------
		{"j-hui/fidget.nvim",
			opts = {
							},
		},
------------------------------------------------------------------
    {'s1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*',
    config = function()
        require'window-picker'.setup()
    end,
		},
----------------------------------------------------------------
	{'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
----------------------------------------------------------------
	{'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
	},
	})
