--- Plugin entrypoint for harpoon-sidebar.nvim
--- Defines user commands and guards against multiple loads.

if vim.g.loaded_harpoon_sidebar then
    return
end
vim.g.loaded_harpoon_sidebar = true

-- Open the Harpoon sidebar in the current window
vim.api.nvim_create_user_command("HarpoonSidebarOpen", function()
    require("harpoon_sidebar").open()
end, { desc = "Open Harpoon sidebar in current window" })

-- Toggle Neo-tree + Harpoon sidebar integration
vim.api.nvim_create_user_command("HarpoonSidebarToggleNeoTree", function()
    require("harpoon_sidebar.neotree").toggle()
end, { desc = "Toggle Neo-tree with Harpoon sidebar split" })
