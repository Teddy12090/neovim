require("config.lazy")

if vim.g.vscode then
    local vscode = require('vscode')

    vim.keymap.set('n', '<S-l>', function() vim.fn.VSCodeNotify('workbench.action.nextEditor') end)
    vim.keymap.set('n', '<S-h>', function() vim.fn.VSCodeNotify('workbench.action.previousEditor') end)
    vim.keymap.set('n', '<C-h>', function() vscode.call('workbench.files.action.showActiveFileInExplorer') end)
    vim.keymap.set('n', '<Tab>', '>>')
    vim.keymap.set('v', '<Tab>', '>')
    vim.keymap.set('n', '<S-Tab>', '<<')
    vim.keymap.set('v', '<S-Tab>', '<')
    
    vim.o.ignorecase = true
    vim.o.smartcase = true
    vim.g.clipboard = vim.g.vscode_clipboard
    vim.opt.clipboard = "unnamedplus"

    vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        callback = function() vim.highlight.on_yank({ timeout = 200 }) end
    })

end
