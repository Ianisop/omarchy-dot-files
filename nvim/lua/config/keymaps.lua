local dap = require("dap")

-- Start / continue debugging
vim.keymap.set("n", "<F6>", function() dap.continue() end, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<F5>", function()
  -- open a terminal split and run the web app
  vim.cmd("split | terminal dotnet run")
end, { desc = "Run Project" })

-- Step controls
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Step Out" })

-- Toggle breakpoints (choose something free, e.g., <leader>db)
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })

-- Conditional breakpoint (e.g., <leader>dB)
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Conditional Breakpoint" })

-- Run last debug session
vim.keymap.set("n", "<leader>dl", function() dap.run_last() end, { desc = "Run Last Debug Session" })
