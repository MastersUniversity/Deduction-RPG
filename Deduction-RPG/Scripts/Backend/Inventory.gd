class_name Inventory

static var player_inventory = []

static func add_item(item):
	player_inventory.append(item)

static func remove_item(item):
	if item in player_inventory:
		player_inventory.remove_at(player_inventory.find(item))
		return Item_Loader.get_item(item)
	return null

static func has_item(item):
	return item in player_inventory
