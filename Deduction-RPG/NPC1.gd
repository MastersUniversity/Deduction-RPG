extends Area2D


func on_interact ():
	if self.name == "CellNote":
		print("cell")
	return self.name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
