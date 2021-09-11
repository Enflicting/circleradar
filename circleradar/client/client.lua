Citizen.CreateThread(function()
    RequestStreamedTextureDict("circlemap", false)
    while not HasStreamedTextureDictLoaded("circlemap") do
        Wait(100)
    end
    
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")

    SetMinimapClipType(1)
    SetMinimapComponentPosition("minimap", "L", "B", 0.025, -0.03, 0.153, Config.MapZoom)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.135, 0.12, 0.093, 0.164)
    SetMinimapComponentPosition("minimap_blur", "L", "B", 0.012, 0.022, 0.256, 0.337)

    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)

    while true do
        Wait(0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

local uiHidden = false

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsBigmapActive() or IsRadarHidden() then
            if not uiHidden then
                SendNUIMessage({
                    action = "hideUI"
                })
                uiHidden = true
            end
        elseif uiHidden then
            SendNUIMessage({
                action = "displayUI"
            })
            uiHidden = false
        end
    end
end)