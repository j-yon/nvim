MainPythonFile = nil
UpdateMainPython = function()
    MainPythonFile = vim.fn.expand("%:p")
    print("Main python file updated to: " .. MainPythonFile)
end

RunMainPython = function()
    if MainPythonFile == nil then
        print("No main python file set. Please update it first.")
    else
        print("Running main python file: " .. MainPythonFile)
        vim.cmd("vs")
        vim.cmd("wincmd l")
        vim.cmd("term python " .. MainPythonFile)
    end
end

MainbashFile = nil
UpdateMainBash = function()
    MainBashFile = vim.fn.expand("%:t")
    print("Main bash file updated to: " .. MainBashFile)
end

RunMainBash = function()
    if MainBashFile == nil then
        print("No Main bash file set. Please update it first.")
    else
        print("Running main bash file: " .. MainBashFile)
        vim.cmd("vs")
        vim.cmd("wincmd l")
        vim.cmd("term bash " .. MainBashFile)
    end
end
