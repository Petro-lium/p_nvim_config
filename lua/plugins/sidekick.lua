return {
	"folke/sidekick.nvim",
	event = "VeryLazy",
	config = function()
		require("sidekick").setup({
			cli = {
				win = {
					layout = "right",
					wo = { winhighlight = "Normal:SidekickChat,NormalNC:SidekickChat" },
				},
			},
		})

		-- Переключение AI CLI: <leader>ko
		vim.keymap.set("n", "<leader>ko", function()
			require("sidekick.cli").toggle()
		end, { desc = "Sidekick: toggle AI CLI" })

		-- Фокус на AI CLI из любого режима
		vim.keymap.set({ "n", "t", "i", "x" }, "<C-_>", function()
			require("sidekick.cli").focus()
		end, { desc = "Sidekick: focus CLI" })

		-- Закрытие AI CLI: <leader>kc
		vim.keymap.set("n", "<leader>kc", function()
			require("sidekick.cli").close()
		end, { desc = "Sidekick: close CLI" })
	end,
}
