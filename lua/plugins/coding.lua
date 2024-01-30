return {
	-- Create annotations with one keybind, and jump your cursor in the inserted annotation
	{
		"danymat/neogen",
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate({})
				end,
				desc = "Neogen Comment",
			},
		},
		opts = { snippet_engine = "luasnip" },
	},
	{
		"uga-rosa/ccc.nvim",
		opts = {},
		cmd = { "CccPick", "CccConvert", "CccHighlighterEnable", "CccHighlighterDisable", "CccHighlighterToggle" },
		keys = {
			{ "<leader>zp", "<cmd>CccPick<cr>", desc = "Pick" },
			{ "<leader>zc", "<cmd>CccConvert<cr>", desc = "Convert" },
			{ "<leader>zh", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle Highlighter" },
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {

			-- `gcc` - Toggles the current line using linewise comment
			-- `gbc` - Toggles the current line using blockwise comment
			-- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
			-- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
			-- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
			-- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
			-- `gc` - Toggles the region using linewise comment
			-- `gb` - Toggles the region using blockwise comment
		},
		lazy = false,
	},
	{

		"mg979/vim-visual-multi",
		lazy = false,
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- calling `setup` is optional for customization
			require("fzf-lua").setup({})
		end,
	},
	-- Incremental rename
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Refactoring tool
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
		end,
	},
	-- Go forward/backward with square brackets
	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		config = function()
			local bracketed = require("mini.bracketed")
			bracketed.setup({
				file = { suffix = "" },
				window = { suffix = "" },
				quickfix = { suffix = "" },
				yank = { suffix = "" },
				treesitter = { suffix = "n" },
			})
		end,
	},

	-- Better increase/descrease
	{
		"monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
					augend.constant.new({ elements = { "let", "const" } }),
				},
			})
		end,
	},

	{
		"simrat39/symbols-outline.nvim",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		cmd = "SymbolsOutline",
		opts = {
			position = "right",
		},
	},

	{
		"nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
	--- Debugging
}
