return { -- Autoformat
  "stevearc/conform.nvim",
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      html = { "djlint" },
      go = { "gofmt", "goimports" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      clang_format = {
        prepend_args = {
          "--style=file:" .. vim.fn.expand("~/.config/nvim/.clang-format"),
          "--fallback-style=Google",
        },
      },
      stylua = {
        args = { "-f", vim.fn.expand("~/.config/nvim/stylua.toml") },
      },
    },
  },
}
