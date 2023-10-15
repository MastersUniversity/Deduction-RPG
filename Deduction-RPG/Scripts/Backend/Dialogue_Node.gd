class_name Dialogue_Node

# Data about the node
var text = ""   # What the NPC says
var type = 0    # What type is the dialogue
var action = "" # What action (if any) does this perform
var connections = {} # What choices are available? {description : jump_index}


# Adds a dictionary entry with the player's response
# and the index of what response the NPC will give next
func add_connection(description, index):
	connections[description] = index


# Set values of variables
func set_text(new_text):
	text = new_text

func set_type(new_type):
	type = new_type

func set_action(new_action):
	action = new_action


# Get the player's responses
func get_descriptions():
	return connections.keys()
