extends Node2D

var mood = 0
var age = 5
var leg_status = 0
var gender = false
var crazy = false
var shaved = false

var color_coat
var color_mane
var color_eye

var has_horn = true
var has_wings = true

const SAVE_GAME_PATH := "user://fluffybreeder.save"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
	

func save():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.WRITE)
	var data = {"mood": mood, "age": age, "coat": color_coat}
	file.store_var(data)

func load():
	var file = FileAccess.open(SAVE_GAME_PATH, FileAccess.READ)
	var data = file.get_var()
	
	mood = data["mood"]
	age = data["age"]
	color_coat = data["coat"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Sprites/Body.modulate = color_coat
	$Sprites/Legs.modulate = color_coat
	$Sprites/Legs2.modulate = color_coat
	$Sprites/Ears.modulate = color_coat
	$Sprites/Wings.modulate = color_coat
	
	$Sprites/Eyes.modulate = color_eye
	
	$Sprites/Mane.modulate = color_mane
	$Sprites/Tail.modulate = color_mane
	
	$Sprites/Horn.visible = has_horn
	$Sprites/Wings.visible = has_wings
	
	var bodyIndex = 0
	var mouthIndex = 0
	var whitesIndex = 0
	var eyeIndex = 0
	var wingIndex = 0
	var earIndex = 0
	var maneIndex = 0
	var tailIndex = 0
	var hornIndex = 0
	var legIndex = 0
	var teatIndex = 0
	
	match leg_status:
		1: # huggy
			legIndex += 1
			teatIndex += 1
			$Sprites/Legs2.visible = false
		2: # enf
			legIndex += 2
			teatIndex += 1
			$Sprites/Legs2.visible = false
		3: # pillow
			legIndex += 3
			teatIndex += 1
			$Sprites/Legs2.visible = false
		_: # all legs, no change
			legIndex += 0
			teatIndex += 0
			$Sprites/Legs2.visible = true
		
	$Sprites/Teats.visible = gender
	
	match mood:
		0: # happy, no changes
			mouthIndex += 0
			eyeIndex += 0
			earIndex += 0
		
		1: #
			mouthIndex += 0
			eyeIndex += 1
			earIndex += 0

		2: #
			mouthIndex += 0
			eyeIndex += 1
			earIndex += 2

		3: #
			mouthIndex += 0
			eyeIndex += 2
			earIndex += 0

		4: #
			mouthIndex += 0
			eyeIndex += 2
			earIndex += 2

		5: # Neutral
			mouthIndex += 1
			eyeIndex += 0
			earIndex += 0

		6: # Neutral
			mouthIndex += 1
			eyeIndex += 0
			earIndex += 2

		7: # Neutral
			mouthIndex += 1
			eyeIndex += 1
			earIndex += 0

		8: # Neutral
			mouthIndex += 1
			eyeIndex += 1
			earIndex += 2

		9: # Neutral
			mouthIndex += 1
			eyeIndex += 2
			earIndex += 0

		10: # Neutral
			mouthIndex += 1
			eyeIndex += 2
			earIndex += 2

		11: # Sad
			mouthIndex += 2
			eyeIndex += 0
			earIndex += 0

		12: # Sad
			mouthIndex += 2
			eyeIndex += 0
			earIndex += 2

		13: # Sad
			mouthIndex += 2
			eyeIndex += 1
			earIndex += 0

		14: # Sad
			mouthIndex += 2
			eyeIndex += 1
			earIndex += 2

		15: # Sad
			mouthIndex += 2
			eyeIndex += 2
			earIndex += 0

		16: # Sad
			mouthIndex += 2
			eyeIndex += 2
			earIndex += 2

		17: # Angry
			mouthIndex += 3
			eyeIndex += 0
			earIndex += 0

		18: # Angry
			mouthIndex += 3
			eyeIndex += 0
			earIndex += 2

		19: # Angry
			mouthIndex += 3
			eyeIndex += 1
			earIndex += 0

		20: # Angry
			mouthIndex += 3
			eyeIndex += 1
			earIndex += 2

		21: # Angry
			mouthIndex += 3
			eyeIndex += 2
			earIndex += 0

		22: # Angry
			mouthIndex += 3
			eyeIndex += 2
			earIndex += 2


	if (crazy):
		eyeIndex += 3
	
	if (shaved):
		wingIndex += 1
		tailIndex += 1
		earIndex += 1
		hornIndex += 1
		maneIndex += 1
	
	teatIndex = 1
	
	$Sprites/Body.frame_coords = Vector2i(age, bodyIndex)
	$Sprites/Mouth.frame_coords = Vector2i(age, mouthIndex)
	$Sprites/EyeWhites.frame_coords = Vector2i(age, whitesIndex)
	$Sprites/Eyes.frame_coords = Vector2i(age, eyeIndex)
	$Sprites/Wings.frame_coords = Vector2i(age, wingIndex)
	$Sprites/Ears.frame_coords = Vector2i(age, earIndex)
	$Sprites/Mane.frame_coords = Vector2i(age, maneIndex)
	$Sprites/Tail.frame_coords = Vector2i(age, tailIndex)
	$Sprites/Horn.frame_coords = Vector2i(age, hornIndex)
	$Sprites/Legs.frame_coords = Vector2i(age, legIndex)
	$Sprites/Legs2.frame_coords = Vector2i(age, 4)
	$Sprites/Teats.frame_coords = Vector2i(age, 1)
