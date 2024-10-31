return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = 'cpp',
      sync_install = false,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true
      }
    })
  end,
  build = ':TSUpdate',
  lazy = true,
  event = 'BufRead',
}

