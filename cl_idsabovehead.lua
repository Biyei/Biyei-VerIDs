local disPlayerNames = 5
local playerDistances = {}
local verid = false


ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterCommand("verids", function(source) 
    
    if verid then
        ESX.ShowNotification("Has ~r~Desactivado~w~ ver ID")
        verid = false
    else
        ESX.ShowNotification("Has ~g~Activado~w~ ver ID")
        verid = true
    end
  end)



local function DrawText3D(position, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(position.x,position.y,position.z+1)
    local dist = #(GetGameplayCamCoords()-position)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0*scale, 0.55*scale)
        else 
            SetTextScale(0.0*scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	Wait(500)
    while true do
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= PlayerPedId() then
                if playerDistances[id] then
                    if playerDistances[id] < disPlayerNames then
                        local targetPedCords = GetEntityCoords(targetPed)
                        if NetworkIsPlayerTalking(id) then
                            DrawText3D(targetPedCords, GetPlayerServerId(id), 79,255,86)
                        else
                            if verid then
                                DrawText3D(targetPedCords, GetPlayerServerId(id), 255,255,255)
                            end
                            
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, id in ipairs(GetActivePlayers()) do
            local targetPed = GetPlayerPed(id)
            if targetPed ~= playerPed then
                local distance = #(playerCoords-GetEntityCoords(targetPed))
				playerDistances[id] = distance
            end
        end
        Wait(1000)
    end
end)