extends BoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var blue = load("res://light_blue128.png")
	var i = 0
	while len(Inventory.player_inventory) > i:
		var itemObj = Inventory.player_inventory[i]
		var nameText = itemObj.name
		var textureObj = load(itemObj.image)
		var descriptionText = itemObj.description
		
		#create item slot
		var vbox = VBoxContainer.new()
		vbox.set_custom_minimum_size(Vector2(128,0))
		vbox.set_tooltip_text(descriptionText)
		#create item texture
		var textureField = TextureRect.new()
		textureField.set_texture(textureObj)
		vbox.add_child(textureField)
		#create item name label
		var label1 = Label.new()
		label1.text = nameText
		label1.set_horizontal_alignment(1)
		vbox.add_child(label1)
		# Add the VBoxContainer to the scene
		self.add_child(vbox)
		
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
