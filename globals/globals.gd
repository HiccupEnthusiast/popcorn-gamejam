extends Node

var player: Player
var camera: PlayerCamera 
var inventory: Inventory

var available_names = ["Anna", "John", "Ringo"]
var available_customers: Array[CustomerInfo] = []
var active_customers: Array[CustomerInfo] = []

const TRAITS = ["patient", "kind", "sweettooth"]

func can_spawn_customer() -> bool:
	return available_customers.size() > 0 or available_names.size() > 0

func new_customer() -> CustomerInfo:
	var info = CustomerInfo.new()
	var _name = get_new_name()
	if _name == null: return null
	info.name = _name
	info.traits = get_random_traits()
	available_customers.append(info)
	Log.i("New customer: %s" % info.repr())
	return info

func get_random_customer() -> CustomerInfo:
	if available_customers.size() == 0: 
		var c = new_customer()
		available_customers.remove_at(0)
		active_customers.append(c)
		return c
	var idx = randi() % available_customers.size()
	var customer = available_customers[idx]
	available_customers.remove_at(idx)
	Log.i("Fetched existing customer: %s" % customer.repr())
	active_customers.append(customer)
	return customer

func deactive_customer(customer: CustomerInfo):
	available_customers.append(customer)
	active_customers.remove_at(active_customers.find(customer))

func get_new_name():
	if available_names.size() == 0: return null
	var idx = randi() % available_names.size()
	var _name = available_names[idx]
	available_names.remove_at(idx)
	return _name

func get_random_traits() -> PackedStringArray:
	var traits: Dictionary[String, bool] = {}
	var num = randi_range(0, 3)
	for i in range(num):
		var idx = randi() % TRAITS.size()
		traits[TRAITS[idx]] = true
	
	var res = PackedStringArray()
	var keys = traits.keys()
	res.resize(keys.size())
	for i in range(keys.size()):
		res[i] = keys[i]
	return res
