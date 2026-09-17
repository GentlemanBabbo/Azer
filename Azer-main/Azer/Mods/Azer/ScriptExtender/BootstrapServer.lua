------------------------------------
-- BG3SX Compatibility
------------------------------------
if Mods.BG3SX then
  local bg3sxWhitelist = Mods.BG3SX.Data.AllowedTagsAndRaces
  bg3sxWhitelist["ReallyAzer"] = {TAG = "3c881972-fd84-4ffd-a528-1f5bf89bcd63", Allowed = true} -- set Allowed to true or false
  bg3sxWhitelist["Azer"] = {TAG = "2e5eb691-a3cb-4c34-8a4b-f99ba9c492d7", Allowed = true} -- set Allowed to true or false

end
