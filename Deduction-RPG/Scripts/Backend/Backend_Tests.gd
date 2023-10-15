extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# (Ignore this part for now)
	Save.save_npc_states()
	Save.load_npc_states()
	print(Save.get_npc_states())
	
	# Start a conversation
	print(Dialogue_Loader.start_conversation(1))
	print(Dialogue_Loader.get_response(1,"Where are we?"))
	print(Dialogue_Loader.get_response(1,"Yes"))
	print(Dialogue_Loader.get_response(1,"We're in a a dungeon."))
	
	# Restart the conversation (conversation restarts at beginning of current state)
	var result = Dialogue_Loader.start_conversation(1)
	print(result)
	print(Dialogue_Loader.get_response(1,result[1][1]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
