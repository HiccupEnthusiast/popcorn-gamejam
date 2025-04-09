class_name Recipe extends Resource

@export var materials: Array[InventoryItem]
@export var product: Product

func _init(_materials: Array[InventoryItem], _product: Product):
	materials = _materials
	product = _product

func repr() -> String:
	var mats_repr: String = ", ".join(materials.map(func(x): return x.repr()))
	return "%s :[%s] -> %s" % [product.name, mats_repr, product.repr()]
