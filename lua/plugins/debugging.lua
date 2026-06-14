return {
	{
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			require("dapui").setup()
			require("nvim-dap-virtual-text").setup()

			local dap_python = require("dap-python")
			dap_python.setup("python")
			dap_python.resolve_python = function()
				local python = require("venv-selector").python()
				if python then
					return python
				end
				if vim.env.VIRTUAL_ENV then
					return vim.env.VIRTUAL_ENV .. "\\Scripts\\python.exe"
				end
				return "python"
			end

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "debug: toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "debug: continue" })
			vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "debug: toggle UI" })
		end,
	},
}
