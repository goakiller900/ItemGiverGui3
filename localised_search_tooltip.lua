-- Localise the extra tooltip details added by the expanded-search beta without
-- duplicating the expanded search implementation itself.

local update_gui_with_expanded_search = igg.update_gui
local SETTING_NAME = "igg-expanded-search"

local function expanded_search_enabled(player)
  local player_settings = settings.get_player_settings(player)
  local setting = player_settings[SETTING_NAME]
  return setting and setting.value == true
end

function igg.update_gui(player, text, amnt)
  local result = update_gui_with_expanded_search(player, text, amnt)

  if not expanded_search_enabled(player) then
    return result
  end

  local flow = igg:get_gui(player.gui.center, "igg_cmd_flow")
  if not flow or not flow.igg_cmd_suggest then
    return result
  end

  local table_element = flow.igg_cmd_suggest.igg_cmd_tab
  if not table_element then
    return result
  end

  local amount_text = amnt
  if not amount_text then
    local amount_field = igg:get_gui(player.gui.center, "igg_cmd_amount")
    amount_text = amount_field and amount_field.text or "0"
  end

  local amount = tonumber(amount_text) or 0
  if amount < 0 then amount = 0 end
  amount = math.floor(amount)

  for _, element in pairs(table_element.children) do
    if element.type == "sprite-button" and string.match(element.name, "igg%_match%_") then
      local item_name = string.sub(element.name, 11)
      local prototype = prototypes.item[item_name]
      if prototype then
        element.tooltip = {
          "",
          prototype.localised_name,
          "\n",
          {"igg3.amount"},
          " ",
          tostring(amount),
          "\n",
          {"igg3.prototype-label"},
          ": ",
          item_name
        }
      end
    end
  end

  return result
end
