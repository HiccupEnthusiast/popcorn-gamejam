class_name Inventory extends Resource

@export var items: Dictionary[String, InventoryItem]
@export var recipes: Dictionary[String, Recipe]

func add_item(item: Ingredient) -> void:
	if items.has(item.name):
		items[item.name].quantity += 1
	else: 
		items[item.name] = InventoryItem.new(item, 1)

func add_recipe(recipe: Recipe) -> void:
	recipes[recipe.product.name] = recipe

func get_item(name: String) -> InventoryItem:
	return items[name]

func use_item(name: String, qty: int) -> bool:
	if items.has(name):
		items[name].quantity -= qty
		return true
	return false

func items_values() -> Array[InventoryItem]:
	var res: Array[InventoryItem]
	res.assign(items.values())
	return res

func recipes_values() -> Array[Recipe]:
	var res: Array[Recipe]
	res.assign(recipes.values())
	return res
