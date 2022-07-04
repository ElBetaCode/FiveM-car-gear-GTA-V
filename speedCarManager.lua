Citizen.CreateThread(function()
    local speedlimit = 0.1
    local marcha = 0
    local status = false
    Wait(50)
    local driver = PlayerPedId()
    while true do
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if vehicle ~= 0
    then
        if IsControlJustReleased(0,21) and marcha ~= 6 and status ~= true then
            marcha = marcha + 1
        elseif IsControlJustReleased(0,36) and marcha ~= 0 and status ~= true then
            status = true
            TaskVehicleTempAction(
                driver --[[ Ped ]], 
                vehicle --[[ Vehicle ]], 
                1 --[[ integer ]], 
                600 --[[ integer ]]
                )
            marcha = marcha - 1
            Citizen.SetTimeout(600, function(source,args) SetVehicleMaxSpeed(vehicle, speedlimit) status = false end)
            end
    speedlimit = marcha * 10.9 + 0.1
    if status ~= true then
        SetVehicleMaxSpeed(vehicle, speedlimit)
    end
    local speed = GetEntitySpeed(vehicle)
    draw(0.815, 1.435, 1.0,1.0,0.50, "~b~KM/h:~r~  ".. Round(speed * 3.6) .. '', 255, 255, 255, 255)
    draw(0.865, 1.435, 1.0,1.0,0.50, "~b~Marcha:~r~  ".. marcha .. '', 255, 255, 255, 255)
    elseif vehicle == 0 then
        marcha = 0
    end        
    Citizen.Wait(1)
    end
end)

function draw(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
	SetTextColour( 0,0,0, 255 )
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
	SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end