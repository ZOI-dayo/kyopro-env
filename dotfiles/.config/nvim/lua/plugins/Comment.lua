return {
  'numToStr/Comment.nvim',
  config = function()
    vim.keymap.set('n', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle.linewise.current()<CR>')
    vim.keymap.set('n', '<C-/>', '<ESC><CMD>lua require("Comment.api").toggle.linewise.current()<CR>')
    vim.keymap.set('v', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
    vim.keymap.set('v', '<C-/>', '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')
    require('Comment').setup({})
  end,
}
