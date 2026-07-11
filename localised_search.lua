-- Proof of concept: search by both internal prototype name and the
-- translated item name shown to the current player.
--
-- This module is intentionally isolated from the original control.lua so the
-- experiment can be reviewed or removed without rewriting the existing code.

local CACHE_KEY = "igg_localised_item_search"

local function get_caches()
  storage[CACHE_KEY] = storage[CACHE_KEY] or {}
  return storage[CACHE_KEY]
end

local function start_translation_cache(player)
  local cache = {
    locale = player.locale,
    names = {},
    pending = {},
    remaining = 0,
    ready = false
  }

  get_caches()[player.index] = cache

  local localised_strings = {}
  local prototype_names = {}

  for prototype_name, prototype in pairs(prototypes.item) do
    table.insert(localised_strings, prototype.localised_name)
    table.insert(prototype_names, prototype_name)
  end

  if #localised_strings == 0 then
    cache.ready = true
    return cache
  end

  local request_ids = player.request_translations(localised_strings)

  for index, request_id in ipairs(request_ids) do
    cache.pending[request_id] = prototype_names[index]
    cache.remaining = cache.remaining + 1
  end

  if cache.remaining == 0 then
    cache.ready = true
  end

  return cache
end

local function ensure_translation_cache(player)
  local cache = get_caches()[player.index]

  if not cache or cache.locale ~= player.locale then
    cache = start_translation_cache(player)
  end

  return cache
end

local function normalise(value)
  return string.lower(value or "")
end

local function item_matches(cache, prototype_name, query)
  if query == "" then
    return true
  end

  if string.find(normalise(prototype_name), query, 1, true) then
    return true
  end

  local localised_name = cache.names[prototype_name]
  if localised_name and string.find(localised_name, query, 1, true) then
    return true
  end

  return false
end

local function add_match(matches, player, prototype, name, amount, selected_list)
  if (not prototype.hidden or show_hidden(player))
    and isListed(selected_list, prototype)
  then
    table.insert(matches, {
      name = name,
      amount = amount
    })
  end
end

local original_open_gui = igg.open_gui

function igg.open_gui(player)
  ensure_translation_cache(player)
  original_open_gui(player)
end

-- Keep the icon button behaviour, but make it obvious that a translated result
-- still selects the stable internal prototype name.
function image(item_name, amount)
  if not amount then amount = 0 end

  local item = prototypes.item[item_name]
  local tooltip = {
    "",
    {"igg.item-name", item.localised_name, amount},
    "\nPrototype: ",
    item_name
  }

  return {
    type = "sprite-button",
    name = "igg_match_" .. item_name,
    tooltip = tooltip,
    sprite = "item/" .. item_name
  }
end

-- Replacement for the original search renderer. The filters and result buttons
-- stay the same; only the matching logic also checks the translated item name.
function igg.update_gui(player, text, amnt)
  try_init()
  local cache = ensure_translation_cache(player)

  if not text then
    text = igg:get_gui(player.gui.center, "igg_cmd_item").text
  end

  if not amnt then
    amnt = igg:get_gui(player.gui.center, "igg_cmd_amount").text
  end

  local query = normalise(text)
  local flow = igg:get_gui(player.gui.center, "igg_cmd_flow")

  if flow.igg_cmd_suggest then
    flow.igg_cmd_suggest.destroy()
  end

  local matches = {}
  local proto = prototypes.item
  local selected_list = list(player)

  if show_inventory(player) == true then
    if filter(player) then
      if query ~= "" then
        for _, item in pairs(get_inventory(player)) do
          local prototype = proto[item.name]

          if prototype and item_matches(cache, item.name, query) then
            add_match(matches, player, prototype, item.name, item.amount, selected_list)
          end
        end
      end
    else
      matches = get_inventory(player)
    end
  else
    if filter(player) then
      if query == "" then
        return
      end
    else
      query = ""
    end

    local amount = tonumber(amnt)
    if not amount or math.floor(amount) < 1 then
      amount = 0
    else
      amount = math.floor(amount)
    end

    for _, item_name in pairs(igg.items) do
      local prototype = proto[item_name]

      if prototype and item_matches(cache, item_name, query) then
        add_match(matches, player, prototype, item_name, amount, selected_list)
      end
    end
  end

  if #matches == 0 then
    return
  end

  if sort(player) then
    table.sort(matches, function(left, right)
      local left_name = cache.names[left.name] or normalise(left.name)
      local right_name = cache.names[right.name] or normalise(right.name)

      if left_name == right_name then
        if left.name == right.name then
          return left.amount < right.amount
        end

        return left.name < right.name
      end

      return left_name < right_name
    end)
  end

  local suggest = flow.add({
    type = "scroll-pane",
    name = "igg_cmd_suggest",
    horizontal_scroll_policy = "never",
    vertical_scroll_policy = "auto",
    style = "igg-scroll-pane",
    direction = "horizontal"
  })

  local tab = suggest.add({
    type = "table",
    name = "igg_cmd_tab",
    column_count = 13
  })

  for _, match in pairs(matches) do
    tab.add(image(match.name, match.amount))
  end
end

script.on_event(defines.events.on_string_translated, function(event)
  local cache = get_caches()[event.player_index]
  if not cache then
    return
  end

  local prototype_name = cache.pending[event.id]
  if not prototype_name then
    -- This can be an old request from before the player changed locale.
    return
  end

  cache.pending[event.id] = nil
  cache.remaining = math.max(0, cache.remaining - 1)

  if event.translated then
    cache.names[prototype_name] = normalise(event.result)
  end

  if cache.remaining == 0 then
    cache.ready = true

    local player = game.players[event.player_index]
    if player and igg.gui_is_open(player) then
      igg.update_gui(player)
    end
  end
end)

script.on_event(defines.events.on_player_locale_changed, function(event)
  get_caches()[event.player_index] = nil

  local player = game.players[event.player_index]
  if player then
    ensure_translation_cache(player)

    if igg.gui_is_open(player) then
      igg.update_gui(player)
    end
  end
end)

script.on_configuration_changed(function()
  storage[CACHE_KEY] = {}
end)
