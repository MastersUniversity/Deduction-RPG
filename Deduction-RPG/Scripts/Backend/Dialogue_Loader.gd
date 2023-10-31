class_name Dialogue_Loader

# Stores the current conversation data
static var dialogue = []
static var session_index = 0

# Loads the dialogue of an NPC
static func load_dialogue(npc):
	
	# Opens the file
	var node_file = FileAccess.open("res://Assets/Dialogue/" + npc + "/" + Save.get_npc_state(npc) + "Nodes.txt", FileAccess.READ)

	# Reads until the end of the file
	while not node_file.eof_reached():
		var line = node_file.get_csv_line(",")
		
		# Ignores empty lines
		if line[0] != "":
			
			# Makes a new dialogue node
			var dialogue_node = Dialogue_Node.new()
			
			# Gives it data from the csv
			dialogue_node.set_type(int(line[0]))
			dialogue_node.set_text(line[1])
			dialogue_node.set_action(line[2])
			
			# Adds it to the dialogue
			dialogue.append(dialogue_node)
	
	# Closes the file
	node_file.close()

	# Opens the file
	var edge_file = FileAccess.open("res://Assets/Dialogue/" + npc + "/" + Save.get_npc_state(npc) + "Edges.txt", FileAccess.READ)

	# Reads until the end of the file
	while not edge_file.eof_reached():
		var line = edge_file.get_csv_line(",")
		
		# Ignores empty lines
		if line[0] != "":
			
			# Adds a connection from this dialogue to the next dialogue
			dialogue[int(line[0])].add_connection(line[2],int(line[1]))
	
	# Closes the file
	edge_file.close()


# Starts a conversation by resetting dialogue and loading what comes next
static func start_conversation(npc):
	dialogue = []
	session_index = 0
	load_dialogue(npc)
	return [dialogue[0].text,dialogue[0].get_descriptions()]


# Gets the next NPC response based on the player response chosen (index)
static func get_response(npc, index):
	if index in dialogue[session_index].connections.keys():
		# Update the session index to the next dialogue node
		session_index = dialogue[session_index].connections[index]
		
		# Get data about the next dialogue node 
		var response = [dialogue[session_index].text,dialogue[session_index].get_descriptions()]
		
		# If the dialogue node changes the state
		if dialogue[session_index].type == 2:
			
			# Change the state
			Save.set_npc_state(npc, dialogue[session_index].action)
			
			# Start a new conversation from the new state
			var new_response = start_conversation(npc)
			
			# Override the old response with the new options
			response[1] = new_response[1]
		
		elif dialogue[session_index].type == 3:
			if Inventory.has_item(dialogue[session_index].action):
				response[1].remove_at(1)
			else:
				response[1].remove_at(0)
		
		elif dialogue[session_index].type == 5:
			Inventory.add_item(Item_Loader.get_item(dialogue[session_index].action))
				
		# Return the dialogue
		return response
	else:
		if dialogue[session_index].action == index:
			return get_response(npc, "Correct")
		else:
			return get_response(npc, "Incorrect")
