class_name Save

static var npc_states = ["State1","State1"]


static func save_npc_states():
	var save_file = FileAccess.open("res://Saves/npcs.save", FileAccess.WRITE)
	for i in npc_states:
		save_file.store_line(i)

	save_file.close()


static func load_npc_states():
	var save_file = FileAccess.open("res://Saves/npcs.save", FileAccess.READ)
	var states = []
	
	if save_file:
		while not save_file.eof_reached():
			states.append(save_file.get_line())
		npc_states = states

	save_file.close()

static func get_npc_states():
	return npc_states

static func get_npc_state(npc_index):
	return npc_states[npc_index]

static func set_npc_state(npc_index, state):
	npc_states[npc_index] = state
