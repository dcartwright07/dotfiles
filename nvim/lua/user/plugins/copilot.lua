return {
  { 'github/copilot.vim', name = 'copilot' },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = "canary",
    dependencies = { 'plenary', 'copilot' },
    opts = {
      -- prompts = {
      --   Explain = 'Explain how it works.',
      --   Review = 'Review the following code and provide concise suggestions.',
      --   Tests = 'Briefly explain how the selected code works, then generate unit tests.',
      --   Refactor = 'Refactor the code to improve clarity and readability.',
      -- },
    },
    build = function()
      vim.notify('Please update the remote plugins by running ":UpdateRemotePlugins", then restart Neovim.')
    end,
    event = 'VeryLazy',
  },
}
