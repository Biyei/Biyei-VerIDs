
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("verids", function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent("biyei:verids", xPlayer)
  end)