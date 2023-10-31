class_name Item_Loader

static var items = {}

static func load_items():
	
	# Opens the file
	var item_file = FileAccess.open("res://Assets/Items.txt", FileAccess.READ)

	# Reads until the end of the file
	while not item_file.eof_reached():
		var line = item_file.get_csv_line(",")
		
		# Ignores empty lines
		if line[0] != "":
			
			# Makes a new item
			items[line[0]] = Item.new()
			items[line[0]].set_name(line[0])
			items[line[0]].set_description(line[1])
			items[line[0]].set_image(line[2])
	
	# Closes the file
	item_file.close()

static func get_item(item):
	return items[item]
