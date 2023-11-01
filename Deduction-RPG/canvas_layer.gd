extends CanvasLayer

var accumulator = 0
var fixedTimeStep = 0.016*4#0.016 is a 1/60 fram
var input_entered = false
var wait
signal lockUpdate(boolean)

# Called when the node enters the scene tree for the first time.
func _ready():
	buttonOptions(0)
	$LineEdit.hide()
	$NPC_dialog.visible = false
	$exit_prompt.visible = false
	wait = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	accumulator += delta
	while accumulator > fixedTimeStep:
		accumulator -= fixedTimeStep
	if stateDictionary["npc"] != "":
		$NPC_dialog.visible = true
		var result
		var npcName = stateDictionary["npc"]
		if stateDictionary["loaderResult"] == []:#first interaction
			result = Dialogue_Loader.start_conversation(npcName)
		else:#subsequent interactions
			result = stateDictionary["loaderResult"]
		$NPC_dialog.text = result[0]
			
		if len(result[1]) == 0 :#end of conversation
			buttonOptions(0)
			$exit_prompt.visible = true
			if Input.is_action_just_pressed("interact") and wait :
				wait = false
			elif Input.is_action_just_pressed("interact"):
				$exit_prompt.visible = false
				$NPC_dialog.visible = false
				lockUpdate.emit(true)
				#reset
				stateDictionary["npc"] = ""
				stateDictionary["loaderResult"] = []
		elif result[1][0] == "Correct":
			buttonOptions(0)
			$LineEdit.show()
			if input_entered:
				input_entered = false
				$LineEdit.hide()
				
				buttonOptions(0)
				stateDictionary["loaderResult"]=Dialogue_Loader.get_response(npcName,$LineEdit.text)
				$LineEdit.clear()

		else:#conversation continued
			buttonOptions(len(result[1]))
			
			#applies choice text to buttons
			if len(result[1]) > 0:
				$Button0.text = result[1][0]
			if len(result[1]) > 1:
				$Button1.text = result[1][1]
			if len(result[1]) > 2:
				$Button2.text = result[1][2]	
			if len(result[1]) > 3:
				$Button3.text = result[1][3]
			if len(result[1]) > 4:
				$Button4.text = result[1][4]
			if len(result[1]) > 5:
				$Button5.text = result[1][5]	
			
			#track button pressed
			var choice = -1	
			if $Button0.button_pressed:
				choice = 0 
			elif $Button1.button_pressed:
				choice = 1
			elif $Button2.button_pressed:
				choice = 2
			elif $Button3.button_pressed:
				choice = 3
			elif $Button4.button_pressed:
				choice = 4
			elif $Button5.button_pressed:
				choice = 5
			if choice > -1:
				buttonOptions(0)
				stateDictionary["loaderResult"]=Dialogue_Loader.get_response(npcName,result[1][choice])

func _on_player_npc_interact(npcName):
	stateDictionary["npc"] = npcName 
	
func buttonOptions(onButtons):
	$Button0.visible = onButtons > 0
	$Button1.visible = onButtons > 1
	$Button2.visible = onButtons > 2
	$Button3.visible = onButtons > 3
	$Button4.visible = onButtons > 4
	$Button5.visible = onButtons > 5
		
		
var stateDictionary = {
	"npc" : "",
	"loaderResult" : []
	
}



func _on_line_edit_text_submitted(new_text):
	input_entered = true
