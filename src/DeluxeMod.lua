SMODS.current_mod.id = "DeluxeMod"
SMODS.current_mod.name = "DeluxeMod"
SMODS.current_mod.author = "Mina"
SMODS.current_mod.prefix = "sj"

SMODS.Sound:register_global()

assert(SMODS.load_file("globals.lua"))()

-- Jokers
local mod_path = SMODS.current_mod.path
local joker_src = NFS.getDirectoryItems(mod_path .. "jokers")
for _, file in ipairs(joker_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end