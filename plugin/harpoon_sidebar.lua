--- All `harpoon_sidebar` command definitions.
if vim.g.loaded_harpoon_sidebar then
    return
end
vim.g.loaded_harpoon_sidebar = true

-- optional default keymap
vim.keymap.set("n", "<leader>e", function()
    require("harpoon_sidebar.neotree").toggle()
end, { desc = "Neo-tree + Harpoon sidebar" })
