Config = {}

-- Outfits für verschiedene Rollen
Config.Outfits = {
    god = {
        male = { torso = {287, 2}, arms = {3, 0}, legs = {114, 2}, shoes = {78, 2}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 2}, hat = {-1, 0} },
        female = { torso = {300, 2}, arms = {3, 0}, legs = {121, 2}, shoes = {82, 2}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 2}, hat = {-1, 0} }
    },
    admin = {
        male = { torso = {287, 3}, arms = {3, 0}, legs = {114, 3}, shoes = {78, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} },
        female = { torso = {300, 3}, arms = {3, 0}, legs = {121, 3}, shoes = {82, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} }
    },
    -- test = { | So erstellst du neue Rollen
    --    male = { torso = {287, 3}, arms = {3, 0}, legs = {114, 3}, shoes = {78, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} },
    --    female = { torso = {300, 3}, arms = {3, 0}, legs = {121, 3}, shoes = {82, 3}, undershirt = {15, 0}, armor = {0, 0}, mask = {135, 3}, hat = {-1, 0} }
    -- },
}

-- Whitelist (Spieler mit Rollen)
Config.Whitelist = {
    ["discord:444040414270455810"] = "god", -- Discord-ID von Admin Leon
    -- ["discord:444040414270455810"] = "test", -- Discord-ID von Admin LEON | So vergibst du den Admins die Rollen
}

-- Name des Befehls für Aduty
Config.CommandName = "aduty"

-- Titel des Admin-Menüs
Config.MenuTitle = "Admin Menü"

-- Aktivierbare Funktionen
Config.EnableNoclip = true
Config.EnableTPToMarker = true
Config.EnableTPToPlayer = true
Config.EnableBringPlayer = true
Config.EnableRevivePlayer = true
