return {
  -- Linting support for C/C++
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        c = { "clangtidy" },
        cpp = { "clangtidy" },
      }
      -- Ensure clangtidy uses the .clang-tidy file in the config directory
      lint.linters.clangtidy.args = {
        "--config-file=/home/bi/.config/nvim/.clang-tidy"
      }
    end,
  },
}
