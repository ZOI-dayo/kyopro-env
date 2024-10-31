return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    update_focused_file = {
      enable = true,
    },
    sync_root_with_cwd = true,
    reload_on_bufenter = true,
    auto_reload_on_write = true,
    hijack_cursor = true,
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
    vim.api.nvim_create_user_command('Tree', ':NvimTreeOpen', {})
  end
}
