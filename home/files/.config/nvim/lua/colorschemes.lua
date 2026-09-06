--- This module will load a random colorscheme on nvim startup process.
local utils = require("utils")

local M = {}

local use_theme = vim.cmd.colorscheme

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme_conf = {
  vague = function()
    use_theme("vague")
  end,
}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme_conf))

  -- Load the colorscheme and its settings
  M.colorscheme_conf[colorscheme]()
end

return M
