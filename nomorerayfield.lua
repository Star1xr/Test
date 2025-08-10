local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Win = WindUI:CreateWindow({ Title = "My UI", Size = UDim2.fromOffset(500,400) })
local Main = Win:Section({ Title = "Main" })
local Tab = Main:Tab({ Title = "General" })

Tab:Button({
  Title = "Merhaba",
  Callback = function() WindUI:Notify({ Title = "Buton", Content = "Tıklandı!", Duration = 2 }) end
})

Tab:Toggle({
  Title = "Aç / Kapat",
  Value = false,
  Callback = function(val) print("Toggle:", val) end
})
