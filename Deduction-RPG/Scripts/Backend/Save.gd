class_name Save


static func save_npc_states(states):
	var save_file = FileAccess.open("res://Saves/npcs.save", FileAccess.WRITE)

	for i in states:
		save_file.store_line(i)


static func load_npc_states():
	var save_file = FileAccess.open("res://Saves/npcs.save", FileAccess.READ)
	var states = []
	
	if save_file == null:
		return states
	
	while not save_file.eof_reached():
		states.append(save_file.get_line())
	
	return states
