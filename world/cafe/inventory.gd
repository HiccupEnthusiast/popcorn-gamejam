class_name Inventory extends Resource

@export var items: Dictionary[String, InventoryItem]

func add_item(item: Ingredient) -> void:
	if items.has(item.name):
		items[item.name].quantity += 1
	else: 
		items[item.name] = InventoryItem.new(item, 1)

func get_item(name: String) -> InventoryItem:
	return items[name]

func values() -> Array[InventoryItem]:
	var res: Array[InventoryItem]
	res.assign(items.values())
	return res
