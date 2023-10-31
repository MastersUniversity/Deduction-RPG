extends CharacterBody2D


const SPEED = 150.0
var player_velocity = Vector2()

var interactDist = 64
var facing = Vector2()
@onready var ray_up = $RayCast_UP
@onready var ray_down = $RayCast_DOWN
@onready var ray_left = $RayCast_LEFT
@onready var ray_right = $RayCast_RIGHT

var unlock = true
var iUnlock = true

signal npcInteract(npcName)

func _process (delta):
	#locks actions while in a menu of some kind
	if unlock and iUnlock:
		if Input.is_action_just_pressed("interact"):
			try_interact()
		if Input.is_action_just_pressed("inventory"):
			$"SubViewportContainer/SubViewport/CanvasLayerIn".visible = true
			iUnlock = false
	elif unlock and not iUnlock:
		if Input.is_action_just_pressed("inventory"):
			$"SubViewportContainer/SubViewport/CanvasLayerIn".visible = false
			iUnlock = true
		
func _physics_process(delta):
  
	velocity = Vector2.ZERO
  
	#movement inputs
	if unlock and iUnlock:
		if Input.is_action_pressed("up"):
			velocity.y += -1 * SPEED
			facing = Vector2(0, -1)
		if Input.is_action_pressed("down"):
			velocity.y += SPEED
			facing = Vector2(0, 1)
		if Input.is_action_pressed("left"):
			velocity.x += -1 * SPEED
			facing = Vector2(-1, 0)
		if Input.is_action_pressed("right"):
			velocity.x += SPEED
			facing = Vector2(1, 0)
  
	# normalize the velocity to prevent faster diagonal movement
	player_velocity = player_velocity.normalized()
  
	# move the player
	move_and_slide()



func try_interact ():
	var rayCast = ray_down
	if facing[1] == -1:
		rayCast = ray_up
	elif facing[1] == 1:
		rayCast = ray_down
	elif facing[0] == -1:
		rayCast = ray_left
	elif facing[0] == 1:
		rayCast = ray_right
		
	if rayCast.is_colliding():
		if rayCast.get_collider().has_method("on_interact"):
			var npcID=rayCast.get_collider().on_interact()
			npcInteract.emit(npcID)
			unlock = false
#releases the lock on player movement and interactions
func _on_canvas_layer_lock_update(boolean):
	unlock = boolean
