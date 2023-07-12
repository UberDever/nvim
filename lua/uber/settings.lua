local options = {
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	smarttab = true,
	autoread = true,
	magic = true,
	number = true,
	so = 7,
	ruler = true,
}

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
