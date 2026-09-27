local function InjectAzerEquipmentVisuals()
    -- Protective pcall ensures the engine parses the records smoothly without a thread crash
    pcall(function()
        _P("==================================================")
        _P("!!! AZER MOD CLIENT: EXECUTING MASTER INJECTION !!!")
        _P("==================================================")

        -- Your custom Azer Male EquipmentRace GUID from your files
        local AZER_EQUIP_RACE_UUID = "602afff7-a228-479d-9213-41e6a4117827"

        -- Your custom sculpted mesh VisualResource IDs from your _merged.lsx
        local MALE_AZER_KILT_MESH = "75cfc413-c0ff-4417-8961-4cdfcff9d045"
        local MALE_AZER_BOOTS_MESH = "210cbc61-a36a-447c-b708-e93c82915cb3"

        -- Map vanilla item template UUIDs to your custom visual string definitions
        local azerItemsToOverride = {
            ["f6599c3f-cfcd-4721-9cc2-1df5d8ff0154"] = MALE_AZER_KILT_MESH,  -- ARM_Barbarian RootTemplate
            ["2577a332-8ad2-4e54-b52b-f4f7cc5823a1"] = MALE_AZER_BOOTS_MESH   -- ARM_Shoes_Barbarian RootTemplate
        }

        for templateUUID, customVisualUUID in pairs(azerItemsToOverride) do
            -- Fetch the item's baseline blueprint proxy out of client memory cleanly
            local template = Ext.Template.GetTemplate(templateUUID)
            
            if template and template.Equipment and template.Equipment.Visuals then
                -- Construct a fully isolated custom visual mapping node matching the engine standard
                local newVisualEntry = {
                    MapKey = AZER_EQUIP_RACE_UUID,
                    Visuals = { customVisualUUID }
                }
                
                -- NATIVE PIPELINE RECONSTRUCT: We extract Larian's data rows into a safe list structure,
                -- inject our custom Azer subrace entry right at index 1 for absolute priority,
                -- and push the compiled deck straight back into the item template property block!
                local activeVisualsDeck = {}
                for i = 1, #template.Equipment.Visuals do
                    activeVisualsDeck[i] = template.Equipment.Visuals[i]
                end
                
                -- Forcefully push our entry to priority slot 1
                table.insert(activeVisualsDeck, 1, newVisualEntry)
                
                -- Sync the completed array directly back to the active client template cache
                template.Equipment.Visuals = activeVisualsDeck
                _P(" -> Client: Successfully bound prioritized Azer mesh rows to Template: " .. templateUUID)
            else
                _P(" -> Client Warning: Target template configuration missing for: " .. templateUUID)
            end
        end
        _P("==================================================")
    end)
end

-- Fire the injection precisely during the native database loading timelines on the client thread
Ext.Events.StatsLoaded:Subscribe(InjectAzerEquipmentVisuals)

-- Fallback safety registration forces execution inside the character creation loading timeline
Ext.Events.SessionLoading:Subscribe(function()
    Ext.OnNextTick(InjectAzerEquipmentVisuals)
end)
