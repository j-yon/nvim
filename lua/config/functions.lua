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
        vim.cmd("file python")
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
        vim.cmd("file bash")
    end
end

-- if in psi4 project dir, add function to compile with build.sh
CompilePsi4 = function()
    if vim.fn.getcwd() == "/home/jyon7/gits/psi4" then
        print("Compiling psi4...")
        vim.cmd("vs")
        vim.cmd("wincmd l")
        vim.cmd("term bash build.sh")
        vim.cmd("file build")
    else
        print("Not in Psi4 project directory.")
    end
end
