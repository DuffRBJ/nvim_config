vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.shiftwidth =4


local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
end




