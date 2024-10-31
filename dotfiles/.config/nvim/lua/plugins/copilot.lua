return {
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup({
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-j>",
          accept_word = false,
          accept_line = false,
          next = false,
          prev = false,
          dismiss = false,
        },
      },
      filetypes = {
        cpp = true,
        ["."] = false,
      },
    })
  end,
}
