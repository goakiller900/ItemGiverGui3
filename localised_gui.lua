-- Localised GUI and player-facing messages for Item Giver Gui 3.
-- This module keeps the original search logic intact while replacing hard-coded
-- English interface text with Factorio LocalisedString keys.

local function quality_items()
  local items = {}
  for _, quality_name in ipairs(igg.qualities) do
    local quality = prototypes.quality[quality_name]
    table.insert(items, quality and quality.localised_name or quality_name)
  end
  return items
end

function selected_quality(player)
  local quality_dropdown = igg:get_gui(player.gui.center, "igg_quality")
  if quality_dropdown and quality_dropdown.selected_index > 0 then
    return igg.qualities[quality_dropdown.selected_index]
  end
  return nil
end

function image(item_name, amount)
  if not amount then amount = 0 end
  local item = prototypes.item[item_name]
  return {
    type = "sprite-button",
    name = "igg_match_" .. item_name,
    tooltip = {"igg3.item-tooltip", item.localised_name, amount},
    sprite = "item/" .. item_name
  }
end

function igg.open_gui(player)
  if igg.gui_is_open(player) then
    igg.close_gui(player)
  end

  local ui = player.gui.center.add({type = "frame", name = "igg_gui", direction = "vertical"})
  local cmd_line = ui.add({type = "frame", name = "igg_cmd_frame", direction = "vertical"})
  local flow1 = cmd_line.add({type = "flow", name = "igg_line1", direction = "horizontal"})

  flow1.add({type = "label", caption = {"igg3.item"}})
  flow1.add({type = "textfield", name = "igg_cmd_item"})
  flow1.add({type = "label", caption = {"igg3.amount"}})
  flow1.add({type = "textfield", name = "igg_cmd_amount", text = "1"})

  local flow2 = cmd_line.add({type = "flow", name = "igg_line2", direction = "horizontal"})
  local types = {
    {"igg3.category-all"},
    {"igg3.category-ammo"},
    {"igg3.category-armor"},
    {"igg3.category-belt"},
    {"igg3.category-capsule"},
    {"igg3.category-fuel"},
    {"igg3.category-gun"},
    {"igg3.category-module"},
    {"igg3.category-tool"}
  }

  flow2.add({type = "checkbox", name = "igg_hidden", caption = {"igg3.show-hidden"}, state = false})
  flow2.add({type = "checkbox", name = "igg_filter", caption = {"igg3.filter"}, state = true})
  flow2.add({type = "checkbox", name = "igg_sort", caption = {"igg3.sort"}, state = false})
  flow2.add({type = "label", caption = {"igg3.item-type"}})
  flow2.add({type = "drop-down", name = "igg_list", items = types, selected_index = 1})
  flow2.add({type = "label", caption = {"igg3.quality"}})
  flow2.add({type = "drop-down", name = "igg_quality", items = quality_items(), selected_index = 1})

  local buttons = flow1.add({type = "flow", name = "igg_cmd_buttons", direction = "horizontal"})
  buttons.add({type = "button", name = "igg_take_button", caption = {"igg3.remove"}})
  buttons.add({type = "button", name = "igg_give_button", caption = {"igg3.give"}})

  ui.add({type = "flow", name = "igg_cmd_flow", direction = "horizontal"})
end

-- Replace the original click handler so validation and result messages are localised.
script.on_event(defines.events.on_gui_click, function(event)
  local player = game.players[event.player_index]
  local element = event.element

  if element.name == "igg_give_button" or element.name == "igg_take_button" then
    local cmd = element.parent.parent

    if cmd.igg_cmd_item.text == "" then
      player.print({"igg3.item-blank"})
      return
    elseif cmd.igg_cmd_amount.text == "" then
      player.print({"igg3.amount-blank"})
      return
    elseif not tonumber(cmd.igg_cmd_amount.text) then
      player.print({"igg3.amount-invalid"})
      return
    elseif tonumber(cmd.igg_cmd_amount.text) <= 0 then
      player.print({"igg3.amount-positive"})
      return
    end

    if element.name == "igg_give_button" then
      give(player, cmd.igg_cmd_item.text, tonumber(cmd.igg_cmd_amount.text))
    else
      take(player, cmd.igg_cmd_item.text, tonumber(cmd.igg_cmd_amount.text))
    end

    igg.update_gui(player, cmd.igg_cmd_item.text, cmd.igg_cmd_amount.text)
  elseif element.type == "sprite-button" then
    if element.name ~= "" and string.match(element.name, "igg%_match%_") then
      igg:get_gui(player.gui.center, "igg_cmd_item").text = string.sub(element.name, 11)
      igg.update_gui(player)
    end
  end
end)

function give(player, item_name, amount)
  local quality = selected_quality(player)
  local items = prototypes.item

  if items[item_name] then
    local item = {name = item_name, count = amount, quality = quality}
    if player.can_insert(item) then
      local inserted = player.insert(item)
      player.print({"igg3.insert-success", inserted})
    else
      player.print({"igg3.inventory-full"})
    end
  else
    player.print({"igg3.invalid-item"})
  end
end

function take(player, item_name, amount)
  local items = prototypes.item

  if items[item_name] then
    local item = {name = item_name, count = amount}
    local main = player.get_main_inventory()
    if main.find_item_stack(item_name) then
      local removed = player.remove_item(item)
      player.print({"igg3.remove-success", removed})
    else
      player.print({"igg3.nothing-to-remove"})
    end
  else
    player.print({"igg3.invalid-item"})
  end
end
