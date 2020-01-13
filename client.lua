-- /ref for police
-- Made by Crishe

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('ref:addBlip')
AddEventHandler('ref:addBlip', function(id)
	if isPolice() then
	
		local id = GetPlayerFromServerId(id)
		local pedUser = GetPlayerPed(id)
		local blip = GetBlipFromEntity(pedUser)

		if not DoesBlipExist(blip) then
			local blipPoli = AddBlipForEntity(pedUser)

			SetBlipSprite(blipPoli, 1)
			Citizen.InvokeNative( 0x5FBCA48327B914DF, blipPoli, true)
			SetBlipAsShortRange(blipPoli, false)
			SetBlipColour(blipPoli, 1)
			SetBlipScale(blipPoli, 1.1)

			SetBlipNameToPlayerName(blipPoli, id)

			if pedUser == GetPlayerPed(-1) then
				ESX.ShowNotification('Your reference has been activated.')
			else
				ESX.ShowNotification('A police has been activate a reference.')
			end
			

		else
			RemoveBlip(blip)
			if pedUser == GetPlayerPed(-1) then
				ESX.ShowNotification('Your reference has been deactivated.')
			else
				ESX.ShowNotification('A police has been deactivate a reference.')
			end
		end
	end
end)

function isPolice()
    if PlayerData ~= nil then
        local isPolice = false
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            isPolice = true
        end
        return isPolice
    end
end

function showNotification(string)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(string)
	DrawNotification(false, false)
end

RegisterCommand("ref", function (src, args, raw)
    TriggerServerEvent("ref:reference")
end, false)