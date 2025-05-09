RunTerm = function(args)
    vim.cmd("vs")
    vim.cmd("wincmd l")
    vim.cmd("lcd " .. vim.fn.expand("%:p:h"))
    vim.cmd("term " .. args)
end
