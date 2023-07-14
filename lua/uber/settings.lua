local M = {}

local options = {
    history = 500,

	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	smarttab = true,
    smartindent = true,
    autoindent = true,

	autoread = true,
	scrolloff = 8,
	ruler = true,
    wrap = false,
    smartcase = true,
    hlsearch = false,
    incsearch = true,
	magic = true,

	number = true,
    mouse = "",
    encoding = "utf8",
    lisp = true,

    swapfile = false,
    termguicolors = true,
    colorcolumn = "120",
}

function M.setup()
    for k, v in pairs(options) do
        vim.opt[k] = v
    end

    function Beautify(color)
        color = color or "industry"
        vim.cmd.colorscheme(color)

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
    Beautify("kanagawa")
end

return M
