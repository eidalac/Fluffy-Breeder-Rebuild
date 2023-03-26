extends Control

var load_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$MarginContainer/VBoxContainer/MenuBar/VersionLabel.text = "Version: " + SaveManager.game_data_dictionary["Version"]
	
	if (SaveManager.load_on_start >= 0):
		SaveManager.load_game_data(SaveManager.load_on_start)
	else:
		SaveManager.preloaded_fluffy = preload("res://fluffy.tscn")
		SaveManager.game_data_dictionary["Active Fluffies"].push_front(SaveManager.preloaded_fluffy.instantiate())
		SaveManager.game_data_dictionary["Active Fluffies"].append(SaveManager.preloaded_fluffy.instantiate())
		SaveManager.game_data_dictionary["Active Fluffies"].append(SaveManager.preloaded_fluffy.instantiate())
		_on_random_parents_pressed()
	
	SaveManager.game_data_dictionary["Active Fluffies"][0].add_to_group("Persist")
	SaveManager.game_data_dictionary["Active Fluffies"][0].scale = Vector2(0.6, 0.6)
	SaveManager.game_data_dictionary["Active Fluffies"][0].position = Vector2(661, 233)
	SaveManager.game_data_dictionary["Active Fluffies"][0].name = "Child"
	
	SaveManager.game_data_dictionary["Active Fluffies"][1].add_to_group("Persist")
	SaveManager.game_data_dictionary["Active Fluffies"][1].scale = Vector2(0.3, 0.3)
	SaveManager.game_data_dictionary["Active Fluffies"][1].position = Vector2(162, 101)
	SaveManager.game_data_dictionary["Active Fluffies"][1].name = "Mom"
	
	SaveManager.game_data_dictionary["Active Fluffies"][2].add_to_group("Persist")
	SaveManager.game_data_dictionary["Active Fluffies"][2].scale = Vector2(0.3, 0.3)
	SaveManager.game_data_dictionary["Active Fluffies"][2].position = Vector2(173, 355)
	SaveManager.game_data_dictionary["Active Fluffies"][2].name = "Dad"
	
	$MarginContainer/VBoxContainer/PanelContainer.add_child(SaveManager.game_data_dictionary["Active Fluffies"][0])
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer3/GridContainer.add_child(SaveManager.game_data_dictionary["Active Fluffies"][1])
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer3/GridContainer.add_child(SaveManager.game_data_dictionary["Active Fluffies"][2])
	
	get_node("MarginContainer/VBoxContainer/HBoxContainer/OptionButton").select(6)
	get_node("MarginContainer/VBoxContainer/HBoxContainer/Mood_Selection").select(0)
	get_node("MarginContainer/VBoxContainer/HBoxContainer/OptionButton5").select(0)
	
	update_fluffy_one()
	
	load_menu = load("res://SaveSlots.tscn").instantiate()
	$MarginContainer.add_child(load_menu)
	load_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_fluffy_one():
	var my_genome = SaveManager.game_data_dictionary["Active Fluffies"][0].my_genome
	
	var ntc = name_that_color.new()
	
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.clear()
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Fluffy Data:", null, false)
	
	var gender = my_genome.get_gender_value_from_genome()
	var gender_string = "Male"
	if (gender):
		gender_string = "Female"
	_on_check_button_toggled(gender)
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Gender: " + gender_string)

	#my_genome.get_length_value_from_genome()
	var temp_length = my_genome.get_length_value_from_genome()
	var temp_height = my_genome.get_height_value_from_genome()
	var temp_weight = my_genome.get_weight_value_from_genome()
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Length: " + var_to_str(temp_length))
	
	#my_genome.get_height_value_from_genome()
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Height: " + var_to_str(temp_height * temp_length) + " (" + var_to_str(temp_height) + ")")
	
	#my_genome.get_weight_value_from_genome()
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Weight: " + var_to_str(temp_weight * temp_length) + " (" + var_to_str(temp_weight) + ")")
	
	#my_genome.get_lifespan_value_from_genome()
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Max Age: " + var_to_str(my_genome.get_lifespan_value_from_genome()))
	
	#my_genome.get_fertility_value_from_genome()
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Fertility: " + var_to_str(my_genome.get_fertility_value_from_genome()))
	
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Maturity: " + var_to_str(my_genome.get_maturity_value_from_genome()))
		
	var test_coat = my_genome.get_coat_color_from_gennome()
	var test_eye = my_genome.get_eye_color_from_gennome()
	var test_mane = my_genome.get_mane_color_from_gennome()
	_on_color_picker_button_color_changed(Color(test_coat))
	_on_color_picker_button_2_color_changed(Color(test_eye))
	_on_color_picker_button_3_color_changed(Color(test_mane))
	
	$MarginContainer/VBoxContainer/HBoxContainer2/Label.text = "Coat = " + ntc.name(test_coat)[1]
	$MarginContainer/VBoxContainer/HBoxContainer2/Label2.text = "Eye = " + ntc.name(test_eye)[1]
	$MarginContainer/VBoxContainer/HBoxContainer2/Label3.text = "Mane = " + ntc.name(test_mane)[1]
	
	var breed = my_genome.get_breed_from_geneom()
	
	if (breed == 0):
		_on_option_button_2_toggled(false)
		_on_option_button_3_toggled(false)
		$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Breed: Earthy")
	elif (breed == 1):
		_on_option_button_2_toggled(false)
		_on_option_button_3_toggled(true)
		$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Breed: Pegasus")
	elif (breed == 2):
		_on_option_button_2_toggled(true)
		_on_option_button_3_toggled(false)
		$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Breed: Unicorn")
	elif (breed == 3):
		_on_option_button_2_toggled(true)
		_on_option_button_3_toggled(true)
		$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Breed: Alicorn (certain)")
	else:
		_on_option_button_2_toggled(true)
		_on_option_button_3_toggled(true)
		$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Breed: Alicorn (possible)")
	
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Strength: " + var_to_str(my_genome.get_strength_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Energy: " + var_to_str(my_genome.get_energy_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Charm: " + var_to_str(my_genome.get_charm_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Thinking: " + var_to_str(my_genome.get_thinking_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Learning: " + var_to_str(my_genome.get_learning_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Sub Species: " + var_to_str(my_genome.get_subspecies_from_genome()))
	
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Coat Length: " + var_to_str(my_genome.get_coat_length_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Coat Curl: " + var_to_str(my_genome.get_coat_curl_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Coat Density: " + var_to_str(my_genome.get_coat_density_value_from_genome()))
	$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer/ItemList.add_item("Inbreed: " + var_to_str(my_genome.get_inbreeding_value_from_genome()))
	
	#GameDataManager.game_data_dictionary["Fluffies"][0] = $MarginContainer/VBoxContainer/PanelContainer/Fluffy


func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x,
		"pos_y" : position.y,
		"coat color" : $MarginContainer/VBoxContainer/PanelContainer2/ColorPickerButton.color,
		"eye color" : $MarginContainer/VBoxContainer/PanelContainer2/ColorPickerButton2.color,
		"mane color" : $MarginContainer/VBoxContainer/PanelContainer2/ColorPickerButton3.color,
		"age" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.age,
		"horn" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.has_horn,
		"wings" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.has_wings,
		"mood" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.mood,
		"legs" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.leg_status,
		"gender" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.gender,
		"crazy" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.crazy,
		"shaved" : $MarginContainer/VBoxContainer/PanelContainer/Fluffy.shaved
	}
	
	return save_dict


func _on_menu_id_pressed(id):
	match id:
		0:
			#SaveManager.save_game_data()
			load_menu.access_mode = "Save"
			load_menu.popup_centered()

		1:
			#SaveManager.load_game_data()
			load_menu.access_mode = "Load"
			load_menu.popup_centered()
			#update_fluffy_one()
			
			#$MarginContainer/VBoxContainer/PanelContainer.add_child(SaveManager.game_data_dictionary["Active Fluffies"][0])
			#$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer3/GridContainer.add_child(SaveManager.game_data_dictionary["Active Fluffies"][1])
			#$MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer3/GridContainer.add_child(SaveManager.game_data_dictionary["Active Fluffies"][2])
		

		3:
			get_tree().quit()

	return


func _on_color_picker_button_color_changed(color):
	SaveManager.game_data_dictionary["Active Fluffies"][0].color_coat = color
	$MarginContainer/VBoxContainer/PanelContainer2/ColorPickerButton.color = color

func _on_color_picker_button_2_color_changed(color):
	SaveManager.game_data_dictionary["Active Fluffies"][0].color_eye = color
	$MarginContainer/VBoxContainer/PanelContainer2/ColorPickerButton2.color = color

func _on_color_picker_button_3_color_changed(color):
	SaveManager.game_data_dictionary["Active Fluffies"][0].color_mane = color
	$MarginContainer/VBoxContainer/PanelContainer2/ColorPickerButton3.color = color

func _on_option_button_item_selected(index):
	SaveManager.game_data_dictionary["Active Fluffies"][0].age = index - 1
	$MarginContainer/VBoxContainer/HBoxContainer/OptionButton.selected = index

func _on_option_button_2_toggled(button_pressed):
	SaveManager.game_data_dictionary["Active Fluffies"][0].has_horn = button_pressed
	$MarginContainer/VBoxContainer/HBoxContainer/OptionButton2.button_pressed = button_pressed

func _on_option_button_3_toggled(button_pressed):
	SaveManager.game_data_dictionary["Active Fluffies"][0].has_wings = button_pressed
	$MarginContainer/VBoxContainer/HBoxContainer/OptionButton3.button_pressed = button_pressed

func _on_mood_selection_item_selected(index):
	SaveManager.game_data_dictionary["Active Fluffies"][0].mood = index
	$MarginContainer/VBoxContainer/HBoxContainer/Mood_Selection.selected = index

func _on_option_button_5_item_selected(index):
	SaveManager.game_data_dictionary["Active Fluffies"][0].leg_status = index
	$MarginContainer/VBoxContainer/HBoxContainer/OptionButton5.selected = index

func _on_check_button_toggled(button_pressed):
	SaveManager.game_data_dictionary["Active Fluffies"][0].gender = button_pressed
	$MarginContainer/VBoxContainer/HBoxContainer/CheckButton.button_pressed = button_pressed

func _on_check_button_2_toggled(button_pressed):
	SaveManager.game_data_dictionary["Active Fluffies"][0].crazy = button_pressed
	$MarginContainer/VBoxContainer/HBoxContainer/CheckButton2.button_pressed = button_pressed

func _on_check_button_3_toggled(button_pressed):
	SaveManager.game_data_dictionary["Active Fluffies"][0].shaved = button_pressed
	$MarginContainer/VBoxContainer/HBoxContainer/CheckButton3.button_pressed = button_pressed


func _on_button_pressed():
	var rng = RandomNumberGenerator.new()
	_on_color_picker_button_color_changed(Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1)))
	_on_color_picker_button_2_color_changed(Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1)))
	_on_color_picker_button_3_color_changed(Color(rng.randf_range(0, 1), rng.randf_range(0, 1), rng.randf_range(0, 1)))
	
	_on_option_button_item_selected(rng.randi_range(0, 7))
	_on_option_button_2_toggled(bool(rng.randi_range(0, 1)))
	_on_option_button_3_toggled(bool(rng.randi_range(0, 1)))
	_on_mood_selection_item_selected(rng.randi_range(0, 22))
	_on_option_button_5_item_selected(rng.randi_range(0, 3))
	_on_check_button_toggled(rng.randi_range(0, 1))
	_on_check_button_2_toggled(rng.randi_range(0, 1))
	_on_check_button_3_toggled(rng.randi_range(0, 1))


func _on_genetic_generator_pressed():
	SaveManager.game_data_dictionary["Active Fluffies"][0].randomize_genome()
	update_fluffy_one()



func _on_random_parents_pressed():
	SaveManager.game_data_dictionary["Active Fluffies"][1].randomize_genome(1)
	SaveManager.game_data_dictionary["Active Fluffies"][2].randomize_genome(0)
	
	#GameDataManager.game_data_dictionary["Fluffies"][1] = $MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer3/GridContainer/Fluffy2
	#GameDataManager.game_data_dictionary["Fluffies"][2] = $MarginContainer/VBoxContainer/PanelContainer/SplitBox/PanelContainer3/GridContainer/Fluffy3
	



func _on_genetic_generator_2_pressed():

	var my_father_genome = SaveManager.game_data_dictionary["Active Fluffies"][2].my_genome
	var my_mother_genome = SaveManager.game_data_dictionary["Active Fluffies"][1].my_genome
	SaveManager.game_data_dictionary["Active Fluffies"][0].my_genome._cross_breed_genes(my_father_genome.genes, my_mother_genome.genes)
	update_fluffy_one()

