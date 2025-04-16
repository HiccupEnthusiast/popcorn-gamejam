class_name Ingredient extends Resource 

enum Usage {
	VEGETABLE = 1,
	FRUIT = 1 << 2,
	MEAT = 1 << 3,
	DRINK = 1 << 4,
	SWEET = 1 << 5
}

@export var name: String
@export_flags("Vegetable", "Fruit", "Meat", "Drink", "Sweet") var usage: int 
@export var properties: Dictionary[String, float]
