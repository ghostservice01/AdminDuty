# AdminDuty

For all support questions, ask in our [Discord](https://discord.gg/cUbr7bsYNs) support chat. Do not create issues if you need help. Issues are for bug reporting and new features only.

# Dependencies

- <u>[QBCORE](https://github.com/qbcore-framework/qb-core)</u>
- <u>[OX-LIB](https://github.com/overextended/ox_lib)</u>

# Installation

- Download ZIP
- Drag and drop resource into your server files

# Outfits

Create as many outfits as you want. You can assign a role for each outfit that you can give to the players.

```lua
Config.Outfits = {
    god = {
        male = { torso = {287, 2}, arms = {3, 0}, legs = {114, 2}, shoes = {78, 2}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 2}, hat = {-1, 0} },
        female = { torso = {300, 2}, arms = {3, 0}, legs = {121, 2}, shoes = {82, 2}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 2}, hat = {-1, 0} }
    },
    admin = {
        male = { torso = {287, 3}, arms = {3, 0}, legs = {114, 3}, shoes = {78, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} },
        female = { torso = {300, 3}, arms = {3, 0}, legs = {121, 3}, shoes = {82, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} }
    },
    -- test = { | How to create new roles
    --    male = { torso = {287, 3}, arms = {3, 0}, legs = {114, 3}, shoes = {78, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} },
    --    female = { torso = {300, 3}, arms = {3, 0}, legs = {121, 3}, shoes = {82, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} }
    -- },
}
```

# Whitelist

With the whitelist you give certain people with the Discord ID the rights.

```lua
Config.Whitelist = {
    ["discord:444040414270455810"] = "god", -- Discord-ID from Admin Leon
 -- ["discord:444040414270455810"] = "test", -- Discord-ID from Admin LEON | This is how you assign the roles to the admins
}
```

# Activated Functions

You can switch off functions here

```lua
Config.EnableNoclip = true
Config.EnableTPToMarker = true
Config.EnableTPToPlayer = true
Config.EnableBringPlayer = true
Config.EnableRevivePlayer = true
```

# Credits

- Script by <u>[LEON](https://discord.gg/cUbr7bsYNs)</u>
