local fn = vim.fn
local exists = fn.exists

local M = {}

local function gotests(opts)
	if opts.loaded_vim_gotests == true then
		return
	end

	opts.loaded_vim_gotests = true

	if not opts.gotests_bin or opts.gotests_bin == "" then
		opts.gotests_bin = "gotests"
	end

	if not opts.gotests_template_dir or opts.gotests_template_dir == "" then
		opts.gotests_template_dir = ""
	end
end

local function setup_commands(opts)
	local cmds = {
		{
			name = "GoTests",
			cmd = function(range)
				require("gotests.autoload").tests(range.line1, range.line2, opts)
			end,
			opt = {
				range = true,
			},
		},
		{
			name = "GoTestsAll",
			cmd = function()
				require("gotests.autoload").alltests(opts)
			end,
			opt = {},
		},
	}

	for _, cmd in ipairs(cmds) do
		vim.api.nvim_create_user_command(cmd.name, cmd.cmd, cmd.opt)
	end
end

local function setup_mappings()
	local map = vim.keymap.set
	-- Gotests
	-- -- :GoHarness        → generate tests for func at cursor (or visual selection)
	-- :GoHarness!       → generate tests for all funcs in file
	vim.api.nvim_create_user_command("GoHarness", function(opts)
		if opts.bang then
			vim.cmd("GoTestsAll")
		elseif opts.range > 0 then
			vim.cmd(string.format("%d,%dGoTests", opts.line1, opts.line2))
		else
			vim.cmd("GoTests")
		end
	end, { range = true, bang = true, desc = "Generate Go test harness via gotests.nvim" })

	map("n", "<leader>gt", "<cmd>GoHarness<CR>", { desc = "Generate tests for func" })
	map("v", "<leader>gt", ":GoHarness<CR>", { desc = "Generate tests for selection" })
	map("n", "<leader>gT", "<cmd>GoHarness!<CR>", { desc = "Generate tests for all" })
end

function M.setup(opts)
	opts = opts or {}
	gotests(opts)
	setup_commands(opts)
	setup_mappings()
end

return M
