extends StaticBody2D

@export var monitoring_list = []
@export var condition_list = []
var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_open = true
	for i in range(len(monitoring_list)):
		if Save.get_npc_state(monitoring_list[i]) != condition_list[i]:
			is_open = false
		
	if is_open:
		$CollisionShape2D.disabled = true
