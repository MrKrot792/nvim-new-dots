return {
    {
        "mfussenegger/nvim-dap",
        dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" }, -- Добавили nvim-nio
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Настройка GDB (C, C++)
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }

            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                },
            }

            dap.configurations.cpp = dap.configurations.c -- То же самое для C++

            -- Инициализация UI
            dapui.setup()

            -- Открываем UI автоматически при запуске/остановке дебаггера
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Горячие клавиши
            vim.keymap.set("n", "<F5>", function() dap.continue() end)
            vim.keymap.set("n", "<F10>", function() dap.step_over() end)
            vim.keymap.set("n", "<F11>", function() dap.step_into() end)
            vim.keymap.set("n", "<F12>", function() dap.step_out() end)
            vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end)
            vim.keymap.set("n", "<Leader>du", function() dapui.toggle() end)
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } -- Добавили nvim-nio
    },
    {
        "nvim-neotest/nvim-nio" -- Установка nvim-nio
    }
}

