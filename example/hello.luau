--!nonstrict
local label = noctalia.getConfig("label")

local function render()
    barWidget.setText(label)
end

render()

function onIpc(event, payload)
    if event == "set" and payload ~= "" then
        label = payload
        render()
    end
end
