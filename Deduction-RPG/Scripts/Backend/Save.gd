class_name Save

static var npc_states = {"NPC1":"State1"}


static func save_npc_states():
	var save_file = FileAccess.open("res://Saves/npcs.save", FileAccess.WRITE)
	for i in npc_states.keys():
		save_file.store_csv_line([i, npc_states[i]])

	save_file.close()


static func load_npc_states():
	var save_file = FileAccess.open("res://Saves/npcs.save", FileAccess.READ)
	
	if save_file:
		while not save_file.eof_reached():
			var states = save_file.get_csv_line(",")
			if states[0]:
				npc_states[states[0]] = states[1]

	save_file.close()

static func get_npc_states():
	return npc_states

static func get_npc_state(npc_index):
	return npc_states[npc_index]

static func set_npc_state(npc_index, state):
	npc_states[npc_index] = state
