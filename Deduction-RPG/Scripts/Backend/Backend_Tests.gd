extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Save.save_npc_states(["hi", "lol"])
	print(Save.load_npc_states())
	var search = Search_Tree.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
