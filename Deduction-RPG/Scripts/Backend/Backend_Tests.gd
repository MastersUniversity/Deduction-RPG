extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# (Ignore this part for now)
	Save.save_npc_states()
	Save.load_npc_states()
	print(Save.get_npc_states())
	
	# Start a conversation
	print(Dialogue_Loader.start_conversation("NPC1"))
	print(Dialogue_Loader.get_response("NPC1","Where are we?"))
	print(Dialogue_Loader.get_response("NPC1","Yes"))
	print(Dialogue_Loader.get_response("NPC1","We're in a a dungeon."))
	print(Save.get_npc_states())
	
	# Restart the conversation (conversation restarts at beginning of current state)
	var result = Dialogue_Loader.start_conversation("NPC1")
	print(result)
	print(Dialogue_Loader.get_response("NPC1",result[1][1]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
