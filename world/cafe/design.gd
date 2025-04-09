extends CanvasLayer 

class InventoryItemButton:
	var ingredient: Ingredient
	var quantity: int
	var button: Button

	static func create(_item: Ingredient) -> InventoryItemButton:
		var result := InventoryItemButton.new()
		result.ingredient = _item
		result.quantity = 1

		var _button := Button.new()
		_button.text = "%s x1" % [_item.name]
		_button.focus_mode = Control.FOCUS_NONE

		result.button = _button
		return result
	func add() -> void:
		self.quantity += 1
		self.button.text = "%s x%d" % [self.ingredient.name, self.quantity]
	func sub() -> bool:
		self.quantity -= 1
		self.button.text = "%s x%d" % [self.ingredient.name, self.quantity]
		if self.quantity <= 0:
			self.button.queue_free()
		return self.quantity <= 0 


@export var available_contatiner: VBoxContainer 
@export var selected_container: VBoxContainer 
@export var drink_name: LineEdit 
@export var done_button: Button 
var selected_items: Dictionary[String, InventoryItemButton]

func _ready() -> void:
	done_button.pressed.connect(_on_done_pressed)
	for entry in Globals.inventory.items_values():
		var button := Button.new()
		button.text = entry.item.name
		button.focus_mode = Control.FOCUS_NONE
		button.pressed.connect(func():
			drink_name.grab_focus()
			if selected_items.has(entry.item.name):
				selected_items[entry.item.name].add()
			else:
				var nb: InventoryItemButton = InventoryItemButton.create(entry.item)
				selected_items[entry.item.name] = nb
				selected_container.add_child(nb.button)
				nb.button.pressed.connect(func():
					if nb.sub():
						selected_items.erase(nb.ingredient.name)
					drink_name.grab_focus()
					)

			)
		available_contatiner.add_child(button)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		if drink_name.has_focus():
			drink_name.release_focus()
		else:
			queue_free()
	if (Input.is_action_pressed("move_up") or \
	Input.is_action_pressed("move_down") or \
	Input.is_action_pressed("move_left") or \
	Input.is_action_pressed("move_right")) and \
	!drink_name.has_focus():
		queue_free()
	if Input.is_action_pressed("confirm"):
		get_viewport().set_input_as_handled()
		queue_free()

func _on_done_pressed() -> void:
	var ingredients: Array[InventoryItem] = []
	var product = Product.new(drink_name.text)
	for ing in selected_items.values():
		ingredients.append(InventoryItem.new(ing.ingredient, ing.quantity))
	var recipe = Recipe.new(ingredients, product)
	
	Globals.inventory.add_recipe(recipe)
	queue_free()
