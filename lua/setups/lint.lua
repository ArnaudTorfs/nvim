local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true})

vim.api.nvim_create_autocmd({
    "BufWritePost", "BufReadPost", "InsertLeave"
}, {group = lint_augroup, callback = function() require("lint").try_lint() end})

vim.keymap.set("n", "<leader>ml", function() require("lint").try_lint() end,
               {desc = "Lint file"})

-- Configure nvim-lint with linters for each filetype
require("lint").linters_by_ft = {
    cpp = { "cpplint" },
    dockerfile = { "hadolint" },
    go = { "golangci-lint" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    json = { "jsonlint" },
    markdown = { "markdownlint", "vale" },
    php = { "phpcs", "phpstan" },
    sh = { "shellcheck" },
    terraform = { "tflint" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {".tmux.conf", "tmux.conf", "*.tmux"},
  callback = function()
    vim.bo.filetype = "sh"
  end,
})
