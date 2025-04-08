class_name InventoryItem extends Resource

@export var item: Ingredient
@export var quantity: int

func _init(_item: Ingredient, _quantity: int) -> void:
	item = _item
	quantity = _quantity
