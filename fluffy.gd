extends Node2D

class_name Fluffy

var fertility = 0

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

var my_genome = null 

enum GENDER {MALE, FEMALE} 

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		#"parent" : get_parent().get_path(),
		"fertility" : fertility,
		"name" : name,
		"pos_x" : position.x,
		"pos_y" : position.y,
		"scale" : scale.x,
		"mood" : mood,
		"age" : age,
		"leg_status" : leg_status,
		"gender" : gender,
		"crazy" : crazy,
		"shaved" : shaved,
		"color_coat" : color_coat,
		"color_mane" : color_mane,
		"color_eye" : color_eye,
		"has_horn" : has_horn,
		"has_wings" : has_wings,
		"genome" : my_genome.genes
	}
	
	return save_dict

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init(force_gender = -1):
	if (my_genome == null):
		my_genome = Genome.new()
		randomize_genome(force_gender)

func new_from_parents(mother_fluffy, father_fluffy):
	var my_father_genome = father_fluffy.my_genome
	var my_mother_genome = mother_fluffy.my_genome
	my_genome = Genome.new()
	my_genome._cross_breed_genes(my_father_genome.genes, my_mother_genome.genes)
	update_from_genome()


func update_from_genome(force_gender = -1):
	
	if (force_gender == 0):
		my_genome.genes["Gender"] = [1, 0]
	elif (force_gender == 1):
		my_genome.genes["Gender"] = [1, 1]
	
	gender = my_genome.get_gender_value_from_genome()
	
	color_coat = my_genome.get_coat_color_from_gennome()
	color_mane = my_genome.get_mane_color_from_gennome()
	color_eye = my_genome.get_eye_color_from_gennome()
	
	var breed = my_genome.get_breed_from_geneom()
	
	fertility = my_genome.get_fertility_value_from_genome()
	
	if (breed == 0):
		has_horn = false
		has_wings = false
	elif (breed == 1):
		has_horn = false
		has_wings = true
	elif (breed == 2):
		has_horn = true
		has_wings = false
	elif (breed == 3):
		has_horn = true
		has_wings = true
	else:
		has_horn = true
		has_wings = true

func randomize_genome(force_gender = -1):
	my_genome = Genome.new()
	update_from_genome(force_gender)

func get_fertility():
	return fertility

func get_fertility_string():
	match fertility:
		0,1: return "Sterile"
		2: return "Barren"
		3: return "Infertile"
		4: return "Fertile"
		5: return "Fertile"
		6: return "Fruitful"
		7: return "Potent"
		_: return "Undefined"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
	#	print("clicked")
	
	if (color_coat == null):
		return
	$Sprites/Body.modulate = color_coat
	$Sprites/Legs.modulate = color_coat
	$Sprites/Legs2.modulate = color_coat
	$Sprites/Ears.modulate = color_coat
	$Sprites/Wings.modulate = color_coat
	
	if (color_eye == null):
		return
	$Sprites/Eyes.modulate = color_eye

	if (color_mane == null):
		return
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
	
	match leg_status:
		1: # huggy
			legIndex += 1
			$Sprites/Legs2.visible = false
		2: # enf
			legIndex += 2
			$Sprites/Legs2.visible = false
		3: # pillow
			legIndex += 3
			$Sprites/Legs2.visible = false
		_: # all legs, no change
			legIndex += 0
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




func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			
			#if (SaveManager.inspect_mode == false):
			if ($CheckBox.button_pressed):
				$CheckBox.button_pressed = false
				$CheckBox.hide()
			else:
				$CheckBox.show()
				$CheckBox.button_pressed = true
			return


func _on_mouse_entered():
	$CollisionShape2D/Label.visible = SaveManager.inspect_mode


func _on_check_box_toggled(button_pressed):
	if (button_pressed):
		add_to_group("Selected")
	else:
		remove_from_group("Selected")
