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
    
    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            os.execute("im-select com.apple.keylayout.ABC")
        end
    })
    
    -- 從 normal mode 切換到 insert mode 後，直接輸入中文字，會把目前位置的中文字吃掉，然後變成剛才輸入中文的ㄅㄆㄇ
    -- 發現，只要進入 insert mode 輸入英文，在輸入中文就不會有這個問題。所以，以下設定是在進入 insert mode 後，輸入 a 然後刪掉
    -- 這樣就可以避免這個問題
    vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
            local keys = vim.api.nvim_replace_termcodes("a<BS>", true, false, true)
            vim.api.nvim_feedkeys(keys, "n", false)
        end
    })

end
