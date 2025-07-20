-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


local nvimTreeApi = require('nvim-tree.api')
vim.keymap.set('n', '<leader>tt', nvimTreeApi.tree.toggle, {desc = 'Nvim-Tree toggle'})
vim.keymap.set('n', '<leader>to', nvimTreeApi.tree.open, {desc = 'Nvim-Tree open'})
vim.keymap.set('n', '<leader>tc', nvimTreeApi.tree.close, {desc = 'Nvim-Tree close'})
vim.keymap.set('n', '<leader>tr', nvimTreeApi.tree.reload, {desc = 'Nvim-Tree reload'})

-- Set relative line numbers and enable diagnostics
vim.wo.number = true
vim.wo.relativenumber = true
vim.diagnostic.config({
  virtual_text = true,
})

--set list to show tabs and trailing spaces
vim.o.list = true
vim.o.listchars = 'tab:» ,lead:.,trail:.'

--Highlight trailing whitespace
vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg='LightRed' })
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	command = [[
		syntax clear TrailingWhitespace |
		syntax match TrailingWhitespace "\_s\+$"
	]]}
)

-- Linting
vim.keymap.set('n', '<leader>l', function() require('lint').try_lint() end, { desc = 'Lint file' })

-- LSP keymaps
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)