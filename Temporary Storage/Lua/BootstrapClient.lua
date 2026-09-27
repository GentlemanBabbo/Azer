local myEquipmentRaceUuid = "602afff7-a228-479d-9213-41e6a4117027" -- Azer
local myItemsToOverride = {
    -- Item_RT_UUID = {visualUUID1, visualUUID2, visualUUID3, visual4UUID},
    ["f6599c3f-cfcd-4721-9cc2-1df5d8ff0154"] = {"75cfc413-c0ff-4417-8961-4cdfcff9d045"},
    ["2577a332-8ad2-4e54-b52b-f4f7cc5823a1"] = {"210cbc61-a36a-447c-b708-e93c82915cb3"}
}

Ext.Events.StatsLoaded:Subscribe(function()
    for uuid,visualsToAdd in pairs(myItemsToOverride) do
        local template = Ext.Template.Get(uuid)
        -- HashMap<Guid, Array<FixedString>> Visuals
        table.insert(template.Equipment.Visuals, {MapKey = myEquipmentRaceUuid, visualsToAdd})
    end
end)