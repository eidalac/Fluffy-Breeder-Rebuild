extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _make_custom_tooltip(_for_text):
	var tooltip = preload("res://FluffyDetails.tscn").instantiate()
	tooltip.text = ""
	
	if (SaveManager.inspect_mode == false):
		tooltip.text = ""
		return tooltip
	
	var ntc = name_that_color.new()
	
	tooltip.text = ""
	tooltip.text += "Fluffy Data:"
	
	var thisFluffy = get_owner()
	
	if (thisFluffy.my_genome.get_gender_value_from_genome()):
		tooltip.text += ("\nGender: Female")
	else:
		tooltip.text += ("\nGender: Male")
	
	tooltip.text += ("\nLength: " + var_to_str(thisFluffy.my_genome.get_length_value_from_genome()))
	tooltip.text += ("\nHeight: " + var_to_str(thisFluffy.my_genome.get_height_value_from_genome()))
	tooltip.text += ("\nWeight: " + var_to_str(thisFluffy.my_genome.get_weight_value_from_genome()))
	tooltip.text += ("\nMax Age: " + var_to_str(thisFluffy.my_genome.get_lifespan_value_from_genome()))
	tooltip.text += ("\nFertility: " + var_to_str(thisFluffy.my_genome.get_fertility_value_from_genome()))
	tooltip.text += ("\nMaturity: " + var_to_str(thisFluffy.my_genome.get_maturity_value_from_genome()))
	tooltip.text += ("\nCoat Color: " + ntc.name(thisFluffy.my_genome.get_coat_color_from_gennome())[1])
	tooltip.text += ("\nEye Color: " + ntc.name(thisFluffy.my_genome.get_eye_color_from_gennome())[1])
	tooltip.text += ("\nMane Color: " + ntc.name(thisFluffy.my_genome.get_mane_color_from_gennome())[1])
	
	var breed = thisFluffy.my_genome.get_breed_from_geneom()
	
	if (breed == 0):
		tooltip.text += ("\nBreed: Earthy")
	elif (breed == 1):
		tooltip.text += ("\nBreed: Pegasus")
	elif (breed == 2):
		tooltip.text += ("\nBreed: Unicorn")
	elif (breed == 3):
		tooltip.text += ("\nBreed:  Alicorn (certain)")
	else:
		tooltip.text += ("\nBreed:  Alicorn (possible)")

	tooltip.text += ("\nStrength: " + var_to_str(thisFluffy.my_genome.get_strength_value_from_genome()))
	tooltip.text += ("\nEnergy: " + var_to_str(thisFluffy.my_genome.get_energy_value_from_genome()))
	tooltip.text += ("\nCharm: " + var_to_str(thisFluffy.my_genome.get_charm_value_from_genome()))
	tooltip.text += ("\nThinking: " + var_to_str(thisFluffy.my_genome.get_thinking_value_from_genome()))
	tooltip.text += ("\nLearning: " + var_to_str(thisFluffy.my_genome.get_learning_value_from_genome()))
	tooltip.text += ("\nSub Species: " + var_to_str(thisFluffy.my_genome.get_subspecies_from_genome()))
	
	tooltip.text += ("\nCoat Length: " + var_to_str(thisFluffy.my_genome.get_coat_length_value_from_genome()))
	tooltip.text += ("\nCoat Curl: " + var_to_str(thisFluffy.my_genome.get_coat_curl_value_from_genome()))
	tooltip.text += ("\nCoat Density: " + var_to_str(thisFluffy.my_genome.get_coat_density_value_from_genome()))
	tooltip.text += ("\nInbreed: " + var_to_str(thisFluffy.my_genome.get_inbreeding_value_from_genome()))
	

	
	#$Popup.popup(Rect2i(global_position.x - collision_size.x - 300, global_position.y - collision_size.y - 150, 300, 300))
	
	return tooltip
