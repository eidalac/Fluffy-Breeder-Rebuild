extends Control

var load_menu
var feral_window


# Called when the node enters the scene tree for the first time.
func _ready():
	if (SaveManager.load_on_start >= 0):
		SaveManager.load_game_data(SaveManager.load_on_start)
	
	load_menu = load("res://SaveSlots.tscn").instantiate()
	$CenterPanel.add_child(load_menu)
	load_menu.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$LeftSideBar/NinePatchRect/StoreNameButton.text = SaveManager.game_data_dictionary["Store"]["Name"]
	$LeftSideBar/NinePatchRect/StoreFluffiesButton.text = "Store Fluffies (" + String.num_int64(SaveManager.game_data_dictionary["Active Fluffies"].size()) + ")"
	pass


func _on_store_fluffies_button_pressed():
	if ($ScrollContainer.visible):
		$ScrollContainer.hide()
		for n in $ScrollContainer/VBoxContainer.get_children():
			$ScrollContainer/VBoxContainer.remove_child(n)
			#n.queue_free()
		return
	
	for index in SaveManager.game_data_dictionary["Active Fluffies"].size():
		#SaveManager.game_data_dictionary["Active Fluffies"][index].add_to_group("Persist")
		SaveManager.game_data_dictionary["Active Fluffies"][index].scale = Vector2(0.3, 0.3)
		SaveManager.game_data_dictionary["Active Fluffies"][index].position = Vector2(150, 100+(300 * index))
		
		$ScrollContainer/VBoxContainer.add_child(SaveManager.game_data_dictionary["Active Fluffies"][index])
		
		$ScrollContainer/VBoxContainer.custom_minimum_size = Vector2(300, 300 * (SaveManager.game_data_dictionary["Active Fluffies"].size()))
	
	$ScrollContainer.show()


func _on_exit_button_pressed():
	get_tree().quit()

func _on_save_button_pressed():
	load_menu.access_mode = "Save"
	load_menu.popup_centered()

func _on_load_button_pressed():
	load_menu.access_mode = "Load"
	load_menu.popup_centered()


func _on_hunt_ferals_pressed():
	feral_window = load("res://HuntFerals.tscn").instantiate()
	$".".add_child(feral_window)
	# load_menu.hide()


func _on_button_3_toggled(button_pressed):
	SaveManager.inspect_mode = button_pressed
