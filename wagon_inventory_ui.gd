extends CanvasLayer
# Views over the existing carried/stock/ally state, never a second inventory model.

var game
var mode := ""
var section := "supplies"
var overlay: Control
var heading: Label
var summary: Label
var feedback: Label
var tabs: HBoxContainer
var content: VBoxContainer
var close_button: Button

func setup(owner_game: Node) -> void:
	game = owner_game
	layer = 9
	overlay = Control.new()
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(overlay)
	var shade := ColorRect.new()
	shade.color = Color(0.02, 0.02, 0.06, 0.78)
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.add_child(shade)
	var panel := PanelContainer.new()
	panel.position = Vector2(285, 72)
	panel.size = Vector2(710, 590)
	var style := StyleBoxFlat.new()
	style.bg_color = Color("141322")
	style.border_color = Color("c2a56a")
	style.set_border_width_all(2)
	style.set_corner_radius_all(8)
	style.set_content_margin_all(20)
	panel.add_theme_stylebox_override("panel", style)
	overlay.add_child(panel)
	var stack := VBoxContainer.new()
	stack.add_theme_constant_override("separation", 10)
	panel.add_child(stack)
	heading = label(stack, "", 26)
	summary = label(stack, "", 16)
	tabs = HBoxContainer.new()
	stack.add_child(tabs)
	button(tabs, "Supplies", show_section.bind("supplies"), "supplies")
	button(tabs, "Allies", show_section.bind("allies"), "allies")
	button(tabs, "Lolth inventory [I]", open_window.bind("inventory"), "inventory")
	var scroll := ScrollContainer.new()
	scroll.follow_focus = true
	scroll.custom_minimum_size = Vector2(660, 355)
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	stack.add_child(scroll)
	content = VBoxContainer.new()
	content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content.add_theme_constant_override("separation", 8)
	scroll.add_child(content)
	feedback = label(stack, "", 15)
	feedback.custom_minimum_size.x = 660
	close_button = button(stack, "Close / resume [Esc]", close_window, "close")
	overlay.hide()

func label(parent: Node, text_value: String, font_size: int = 16) -> Label:
	var item := Label.new()
	item.text = text_value
	item.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	item.add_theme_font_size_override("font_size", font_size)
	item.add_theme_color_override("font_color", Color("eee5d4"))
	parent.add_child(item)
	return item

func button(parent: Node, title: String, callback: Callable, identity: String) -> Button:
	var item := Button.new()
	item.text = title
	item.custom_minimum_size.y = 34
	item.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	item.set_meta("identity", identity)
	item.pressed.connect(callback)
	parent.add_child(item)
	return item

func is_open() -> bool:
	return is_instance_valid(overlay) and overlay.visible

func toggle_inventory() -> void:
	if is_open() and mode == "inventory":
		close_window()
	else:
		open_window("inventory")

func toggle_wagon() -> void:
	if is_open() and mode == "wagon":
		close_window()
	else:
		open_window("wagon")

func open_window(next_mode: String) -> void:
	if game.state != "journey":
		return
	if next_mode == "wagon" and not game.at_wagon():
		game.message = "Return to the Wagon to manage supplies and allies."
		game.message_time = 2.0
		return
	if is_instance_valid(game.playtester_panel):
		game.playtester_panel.hide()
	game.ui_gameplay_requests.clear()
	game.playtester_resume_guard = true
	mode = next_mode
	overlay.show()
	refresh()
	close_button.grab_focus()

func close_window() -> void:
	if not is_open():
		return
	overlay.hide()
	mode = ""
	game.ui_gameplay_requests.clear()
	game.playtester_resume_guard = true
	var focused := get_viewport().gui_get_focus_owner()
	if is_instance_valid(focused):
		focused.release_focus()

func show_section(next_section: String) -> void:
	section = next_section
	refresh()

func handle_event(event: InputEvent) -> void:
	if event.is_action_pressed("skip"):
		close_window()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("primary"):
		var focused := get_viewport().gui_get_focus_owner()
		if focused is Button and not focused.disabled:
			focused.pressed.emit()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		var focused := get_viewport().gui_get_focus_owner()
		if is_instance_valid(focused):
			var next_focus := focused.find_prev_valid_focus() if event.is_action_pressed("move_left") else focused.find_next_valid_focus()
			if is_instance_valid(next_focus):
				next_focus.grab_focus()
		get_viewport().set_input_as_handled()
	elif event.is_action_pressed("attack") or event.is_action_pressed("shadow_action") or event.is_action_pressed("shadow_strike") or event.is_action_pressed("camp_action"):
		# Mouse events must continue to the widgets, but never to world actions.
		if not event is InputEventMouseButton:
			get_viewport().set_input_as_handled()

func refresh() -> void:
	var focused := get_viewport().gui_get_focus_owner()
	var focused_id := String(focused.get_meta("identity", "")) if is_instance_valid(focused) else ""
	for child in content.get_children():
		content.remove_child(child)
		child.queue_free()
	tabs.visible = mode == "wagon"
	heading.text = "THE WAGON" if mode == "wagon" else "LOLTH'S INVENTORY"
	summary.text = "World paused · E: confirm · Arrows / Tab: navigate"
	if mode == "inventory":
		show_inventory()
	elif section == "allies":
		show_allies()
	else:
		show_supplies()
	feedback.text = String(game.message) if float(game.message_time) > 0.0 else ""
	close_button.text = "Close / resume [I / Esc]" if mode == "inventory" else "Close / resume [M / Esc]"
	for item in content.find_children("*", "Button", true, false):
		if String(item.get_meta("identity", "")) == focused_id and not item.disabled:
			item.grab_focus()
			return
	if not is_instance_valid(get_viewport().gui_get_focus_owner()):
		close_button.grab_focus()

func show_inventory() -> void:
	label(content, "CARRIED LOAD: %d / %d spaces" % [game.load_used(), game.load_capacity()], 20)
	label(content, "These items travel with Lolth. Wagon stock is separate.")
	if game.recovered_load.is_empty():
		label(content, "Your inventory is empty. Explore and press E to gather supplies.")
	for index in game.recovered_load.size():
		var item: Dictionary = game.recovered_load[index]
		var prefix := "Selected · " if index == int(game.selected_load) else ""
		button(content, "%s%s — %d space(s)" % [prefix, item.name, int(item.slots)], select_load.bind(index), "load_%d" % index)
	if game.at_wagon():
		button(content, "Open Wagon menu [M]", open_window.bind("wagon"), "wagon")
	else:
		label(content, "Return to the Wagon to store items or craft.")

func show_supplies() -> void:
	label(content, "WAGON STOCK: %d / %d items" % [game.wagon_stock.size(), game.WAGON_STOCK_CAPACITY], 20)
	var stock_names: PackedStringArray = []
	for item in game.wagon_stock:
		stock_names.append(String(item.name))
	label(content, "Empty stock" if stock_names.is_empty() else ", ".join(stock_names))
	label(content, "CARRIED LOAD: %d / %d spaces" % [game.load_used(), game.load_capacity()])
	for index in game.recovered_load.size():
		var item: Dictionary = game.recovered_load[index]
		var prefix := "Selected · " if index == int(game.selected_load) else ""
		button(content, prefix + String(item.name), select_load.bind(index), "load_%d" % index)
	var store := button(content, "Store selected carried item", store_load, "store")
	store.disabled = game.recovered_load.is_empty() or game.wagon_stock.size() >= game.WAGON_STOCK_CAPACITY
	label(content, "CRAFTING", 20)
	var selected: Dictionary = game.RECIPES[game.selected_recipe]
	var craft := button(content, "Craft " + String(selected.name), craft_recipe, "craft")
	craft.disabled = recipe_locked(int(game.selected_recipe)) or not game.recipe_has_ingredients(selected)
	label(content, String(selected.description))
	for index in game.RECIPES.size():
		var recipe: Dictionary = game.RECIPES[index]
		var prefix := "Selected · " if index == int(game.selected_recipe) else ""
		var entry := button(content, "%s%s — %s" % [prefix, recipe.name, game.recipe_label(recipe)], select_recipe.bind(index), "recipe_%d" % index)
		entry.disabled = recipe_locked(index)

func recipe_locked(index: int) -> bool:
	# Keep the cave tutorial's Wheel Kit selection and later-region recipe boundary.
	return (game.zone == 0 and game.mark_level == 0 and game.tutorial_phase == "day_salvage" and index != game.WHEEL_KIT_RECIPE) or (game.zone == 0 and index == 3)

func select_load(index: int) -> void:
	if index >= 0 and index < game.recovered_load.size():
		game.selected_load = index
	refresh()

func select_recipe(index: int) -> void:
	if not recipe_locked(index):
		game.selected_recipe = index
	refresh()

func store_load() -> void:
	if mode == "wagon" and game.at_wagon() and not game.recovered_load.is_empty():
		game.store_selected_load()
	refresh()

func craft_recipe() -> void:
	if mode == "wagon" and game.at_wagon() and not recipe_locked(int(game.selected_recipe)):
		game.craft_selected_recipe()
	if game.state != "journey":
		close_window()
	else:
		refresh()

func show_allies() -> void:
	label(content, "THE THALESTRIEL: %d / 8 cured" % game.cured_allies.size(), 20)
	if game.zone == 0:
		label(content, "Posts and missions are locked at the cave camp. Cured allies defend the Wagon.")
	else:
		label(content, "MAP POSTS: %d / %d" % [game.posted_allies.size(), game.MAX_ACTIVE_POSTS])
	for ally in game.THALESTRIEL:
		var cured: bool = game.cured_allies.has(ally)
		var assigned: bool = game.posted_allies.has(ally)
		var condition := "Plagued · Resting at the Wagon"
		if cured:
			condition = "Cured · Map post" if assigned else "Cured · Wagon defense"
			if game.downed_drows.has(ally):
				condition = "Cured · Recovering"
		var row := HBoxContainer.new()
		content.add_child(row)
		var name_label := label(row, "%s — %s" % [ally, condition], 14)
		name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var action := button(row, "Recall" if assigned else "Assign post", manage_ally.bind(String(ally)), "ally_" + String(ally))
		action.custom_minimum_size.x = 125
		action.size_flags_horizontal = Control.SIZE_SHRINK_END
		action.disabled = game.zone == 0 or not cured or (not assigned and game.posted_allies.size() >= game.MAX_ACTIVE_POSTS)
		if game.zone == 0:
			action.tooltip_text = "Unavailable at the cave camp."
	label(content, "MISSIONS", 20)
	for index in game.PASSIVE_MISSIONS.size():
		var mission: Dictionary = game.PASSIVE_MISSIONS[index]
		var entry := button(content, ("Selected · " if index == int(game.mission_selected) else "") + String(mission.name), select_mission.bind(index), "mission_%d" % index)
		entry.disabled = game.zone == 0 or game.cured_allies.is_empty()
	var assign := button(content, "Assign selected mission", assign_mission, "assign_mission")
	assign.disabled = game.zone == 0 or game.cured_allies.is_empty() or not game.passive_mission.is_empty()
	if not game.passive_mission.is_empty():
		label(content, "Underway: " + String(game.passive_mission.name))

func manage_ally(ally: String) -> void:
	if mode != "wagon" or not game.at_wagon() or game.zone == 0 or not game.cured_allies.has(ally):
		return
	game.selected_post_ally = game.cured_allies.find(ally)
	game.toggle_selected_post()
	refresh()

func select_mission(index: int) -> void:
	if mode == "wagon" and game.at_wagon() and game.zone != 0 and not game.cured_allies.is_empty():
		game.mission_selected = index
	refresh()

func assign_mission() -> void:
	if mode == "wagon":
		game.assign_mission()
	refresh()
