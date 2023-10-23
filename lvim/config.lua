-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--

-- let g:python3_host_prog  = "/opt/homebrew/Caskroom/miniforge/base/envs/pytorch/bin/python"

lvim.plugins = {
 "mfussenegger/nvim-dap-python",
 "nvim-neotest/neotest",
 "nvim-neotest/neotest-python",
 "AckslD/swenv.nvim",
 "stevearc/dressing.nvim",
 "luukvbaal/nnn.nvim",

}

require("nnn").setup()

lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  -- require("dap-python").setup("/opt/homebrew/Caskroom/miniforge/base/envs/pytest/bin/python")
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

require("neotest").setup({
  adapters = {
    require("neotest-python")({
      dap = {
        justMyCode = false,
        console = "integratedTerminal",
      },
      args = { "--log-level", "DEBUG", "--quiet" },
      runner = "pytest",
    })
  }
})

lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

lvim.builtin.treesitter.ensure_installed = {
  "python",
}

lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}


-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup { { name = "black" }, }

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup { 
--   {
--     command = "flake8",
--     filetypes = { "python" },
--     diagnostics_postprocess = function(diagnostic)
--       diagnostic.severity = vim.diagnostic.severity.INFO
--     end,
--   }
-- }

