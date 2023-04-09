extends Control

var feral_list = []


# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	var count = rng.randi_range(0, 7)
	
	spawn_random_feral_group(count)

func spawn_random_feral_group(count = 1):
	feral_list = []
	$RichTextLabel.text = ""
	
	for child in $ScrollContainer/VBoxContainer.get_children():
		$ScrollContainer/VBoxContainer.remove_child(child)
		child.queue_free()
	
	$RichTextLabel.text = "Huting for ferals you find..."
	$RichTextLabel.append_text("\n" +  String.num_int64(count) + " fluffies.")
	
	for index in count:
		var preloaded_fluffy = preload("res://fluffy.tscn").instantiate()
		preloaded_fluffy.init()
		feral_list.append(preloaded_fluffy)
		feral_list[index].scale = Vector2(0.2, 0.2)
		feral_list[index].position = Vector2(100+(200 * index), 100)
		
		$ScrollContainer/VBoxContainer.add_child(feral_list[index])
	
	$ScrollContainer/VBoxContainer.custom_minimum_size = Vector2(200 * count, 200)
	
	
func spawn_random_feral_family():
	var rng = RandomNumberGenerator.new()
	var age = rng.randi_range(0, 3)
	var preloaded_fluffy
	var litter_size = 0
	
	feral_list = []
	$RichTextLabel.text = ""
	
	for child in $ScrollContainer/VBoxContainer.get_children():
		$ScrollContainer/VBoxContainer.remove_child(child)
		child.queue_free()
	
	preloaded_fluffy = preload("res://fluffy.tscn").instantiate()
	preloaded_fluffy.init(Fluffy.GENDER.MALE)
	feral_list.append(preloaded_fluffy)
	
	preloaded_fluffy = preload("res://fluffy.tscn").instantiate()
	preloaded_fluffy.init(Fluffy.GENDER.FEMALE)
	feral_list.append(preloaded_fluffy)
	
	litter_size = feral_list[0].get_fertility() + feral_list[1].get_fertility()
	litter_size = litter_size / 2
	litter_size = litter_size + rng.randi_range(-1, 4)
	litter_size = clampi(litter_size, 1, 8)
	
	for index in litter_size:
		preloaded_fluffy = preload("res://fluffy.tscn").instantiate()
		preloaded_fluffy.new_from_parents(feral_list[0], feral_list[1])
		preloaded_fluffy.age = age
		feral_list.append(preloaded_fluffy)
	
	$RichTextLabel.text = "Huting for ferals you find..."
	$RichTextLabel.append_text("\n" +  String.num_int64(feral_list.size()) + " fluffies.")
	
	for index in feral_list.size():
		feral_list[index].scale = Vector2(0.2, 0.2)
		feral_list[index].position = Vector2(100+(200 * index), 100)
		
		$ScrollContainer/VBoxContainer.add_child(feral_list[index])
	
	$ScrollContainer/VBoxContainer.custom_minimum_size = Vector2(200 * feral_list.size(), 200)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var selected_fluffies = get_tree().get_nodes_in_group("Selected")
	var selected_count = selected_fluffies.size()
	
	if (selected_count > 0):
		$Take.text = "Take Selected (" + String.num_int64(selected_count) + ")"
		$Take.disabled = false
		return
	else:
		$Take.text = "Take Selected (0)"
		$Take.disabled = true
		return




func _on_close_pressed():
	$".".hide()


func _on_button_pressed():
	spawn_random_feral_group(1)
	
	feral_list[0].age = $Button/OptionButton2.selected - 1


func _on_button_2_pressed():
	spawn_random_feral_family()
	


func _on_button_3_toggled(button_pressed):
	SaveManager.inspect_mode = button_pressed


func _on_take_pressed():
	var selected_fluffies = get_tree().get_nodes_in_group("Selected")
	
	for index in selected_fluffies.size():
		feral_list.erase(selected_fluffies[index])
		SaveManager.game_data_dictionary["Active Fluffies"].append(selected_fluffies[index])
		selected_fluffies[index].get_parent().remove_child(selected_fluffies[index])
		selected_fluffies[index].get_node("CheckBox").button_pressed = false
		selected_fluffies[index].get_node("CheckBox").hide()
		
	for index in selected_fluffies.size():
		selected_fluffies[index].remove_from_group("Selected")
		
	for index in feral_list.size():
		SaveManager.game_data_dictionary["Inactive Fluffies"].append(feral_list[index])
		feral_list[index].get_parent().remove_child(feral_list[index])
		feral_list[index].get_node("CheckBox").button_pressed = false
		feral_list[index].get_node("CheckBox").hide()
	
	$".".hide()

