local currentVersion = "1.0.0" -- Deine aktuelle Skript-Version
local versionURL = "https://raw.githubusercontent.com/ghostservice01/AdminDuty/server/version.lua"

PerformHttpRequest(versionURL, function(err, latestVersion, headers)
    if err ~= 200 then
        print("^1[ERROR] Konnte die neueste Version nicht abrufen.^0")
        return
    end

    if latestVersion then
        latestVersion = latestVersion:gsub("%s+", "")

        if latestVersion ~= currentVersion then
            print("^3[WARNING] Dein Script ist veraltet!^0")
            print("^3[UPDATE] Neue Version verfügbar: " .. latestVersion .. "^0")
            print("^3[UPDATE] Bitte aktualisiere dein Script hier: https://github.com/ghostservice01/AdminDuty^0")
        else
            print("^2[INFO] Dein Script ist auf dem neuesten Stand.^0")
        end
    end
end, "GET", "", {})
