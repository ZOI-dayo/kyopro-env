vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = 'tab:▸-,space:･,eol:↲'
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.shiftwidth = 0
vim.opt.showcmd = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.title = true
vim.opt.virtualedit = 'onemore'
vim.opt.whichwrap = 'b,s,<,>,[,],h,l,~'

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('v', 'x', '"_x')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', '<S-Left>', '<C-w><<CR>')
vim.keymap.set('n', '<S-Right>', '<C-w>>CR>')
vim.keymap.set('n', '<S-Up>', '<C-w>+<CR>')
vim.keymap.set('n', '<S-Down>', '<C-w>-<CR>')
vim.opt.shell = '/bin/bash'

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('AutoCommentOff', { clear = true }),
  command = 'setlocal formatoptions-=cro',
})

vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

require("config.lazy")
