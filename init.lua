require('config.options')
require('config.keybinds')
--require('plugins.mason')


vim.cmd("syntax enable")


vim.g.vimtex_flavor = "latex"
vim.g.maplocalleader = " "

vim.g.vimtex_view_method = "zathura_simple"
--vim.g.vimtex_view_zathura_options = "-reuse-instance"

vim.g.vimtex_view_general_viewer = "zathura"
--do  'cmd.exe /D /c start "" "C:\\Program Files\\SumatraPDF\\SumatraPDF.exe"'

--vim.g.vimtex_view_general_options=  '-reuse-instance -forward-search @tex @line @pdf'
vim.g.vimtex_view_general_options = "--synctex-forward @line:1:@tex @pdf"


--for Ultisnips to refresh snippets after editing so it is possible to use them immediately
vim.keymap.set("n", "<leader>u", function()
  vim.fn["UltiSnips#RefreshSnippets"]()
  vim.notify("UltiSnips snippets refreshed")
end, { desc = "UltiSnips: Refresh snippets" })



local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set




vim.g.UltiSnipsExpandTrigger = "<C-j>"
vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
vim.g.UltiSnipsSnippetDirectories = {

    vim.fn.expand("~/.config/nvim/UltiSnips"),
}



--local hooks = function(ev)
--	local name, kind = ev.data.spec.name, ev.data.kind
--	if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
--		vim.system({ 'make' }, { cwd = ev.data.path }):wait()
--	end
--end
--vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })



vim.pack.add({
	--  "https://github.com/EdenEast/nightfox.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons", -- dependency for lualine
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",  --dependencies: nvim-web-devicons
	"https://github.com/nvim-lua/plenary.nvim",      --dependency for telescope
	"https://github.com/nvim-telescope/telescope.nvim", --dependencies: plenary
	--    "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "master" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	{ src = "https://github.com/ThePrimeagen/harpoon",                        version = "harpoon2" },
	"https://github.com//nvim-treesitter/nvim-treesitter-context",
	'https://github.com/neovim/nvim-lspconfig',
	"https://github.com/williamboman/mason.nvim",
	--LATEX
	"https://github.com/lervag/vimtex",
	"https://github.com/sirver/ultisnips",
	--MAYBE??--
	"https://github.com/ojroques/vim-oscyank", --For ssh tunnelling and copying to clipboard
	"https://github.com/tpope/vim-fugitive", -- Git plugin
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-buffer",
})

--color scheme--
--vim.cmd.colorscheme("nordfox")
vim.cmd.colorscheme("tokyonight")

--PLUGIN SETUP
require("lualine").setup({ opts = { theme = 'tokyonight' } })

require('telescope').setup({})
require('telescope').setup {
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key"
			}
		}
	},
	pickers = {
		find_files = {
			hidden = true, --display hidden files such as config
		}
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	}
}
--  require('telescope').load_extension('fzf')

require('nvim-treesitter').setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				-- Languages to install immediately
				ensure_installed = { "lua", "vim" },

				-- Automatically install missing parsers when entering a buffer
				auto_install = true,

				highlight = {
					enable = true, -- Enable Treesitter-based highlighting
				},
				indent = {
					enable = true, -- Better indentation
				},
			})
		end
	},
})




local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)



-- lsp --

require("mason").setup()

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.enable({ -- :MasonInstall gopls vtsls svelte-language-server tailwindcss-language-server
  "gopls", --   terraform-ls dockerfile-language-server json-lsp yaml-language-server
  "vtsls", --   lua-language-server prettierd goimports stylua
  "svelte",
  "tailwindcss",
  "terraformls",
  "dockerls",
  "jsonls",
  "yamlls",
  "lua_ls",
})

autocmd("LspAttach", {
  group = augroup,
  callback = function(ev)
    local bufopts = { buffer = ev.buf, silent = true }
    map("n", "gd", vim.lsp.buf.definition, bufopts)
    map("n", "gD", vim.lsp.buf.declaration, bufopts)
    map("n", "gI", vim.lsp.buf.implementation, bufopts)
    map("n", "gy", vim.lsp.buf.type_definition, bufopts)
    map("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
    map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })

    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

--autocmd("InsertEnter", {
 -- group = augroup,
--  once = true,
 -- callback = function()
  --  vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
  --  require("copilot").setup({
  --    suggestion = {
    --    auto_trigger = false,
     --   keymap = {
        --  accept = "<Tab>",
    --      accept_word = "<C-Right>",
    --    accept_line = "<C-End>",
      --    next = "<A-]>",
    --    prev = "<A-[>",
      --    dismiss = "<C-]>",
  --      },
 --     },
  --    filetypes = {
  --      markdown = true,
  --      yaml = true,
  --    },
 --   })
--  end,
--})



