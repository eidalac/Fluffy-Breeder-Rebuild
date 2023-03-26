extends Control

var regex
var notice_box

# Called when the node enters the scene tree for the first time.
func _ready():
	regex = RegEx.new()
	regex.compile("^[\\w\\-\\s]+$")
	#^[\w\-\s]+$/
	
	_on_location_item_selected($Difficulty2/Location.selected)
	_on_size_item_selected($Difficulty2/Size.selected)
	
	$Difficulty2/LineEdit2.set_max_length(15)
	$Difficulty2/LineEdit2.set_text(SaveManager.game_data_dictionary["Player"]["Name"])
	$Difficulty2/LineEdit.set_max_length(15)
	$Difficulty2/LineEdit.set_text(SaveManager.game_data_dictionary["Store"]["Name"])
	
	notice_box = load("res://AlertBox.tscn").instantiate()
	$Background.add_child(notice_box)
	notice_box.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_location_item_selected(index):
	match (index):
		0:
			$OptionDetails.text = "On a very remote farm.  Land is cheap but everything else costs more.  Customer are rare."
		1:
			$OptionDetails.text = "In a small, rural county.  Standard prices."
		2:
			$OptionDetails.text = "In a moderate town or suburbs of a large down.  Land is pricey, but you have more customers."
		3:
			$OptionDetails.text = "In a bustling urban center.  Everything is expensive, but so are your fluffies."
	
	SaveManager.game_data_dictionary["Store"]["Location"] = index


func _on_size_item_selected(index):
	match (index):
		0:
			$OptionDetails2.text = "A tiny building with little space.  Little room but least upkeep."
		1:
			$OptionDetails2.text = "A small building.  Less space but more upkeep."
		2:
			$OptionDetails2.text = "A decently sized building."
		3:
			$OptionDetails2.text = "A massive building.  Plenty of room, plenty of bills."
	
	SaveManager.game_data_dictionary["Store"]["Size"] = index


func _on_line_edit_text_submitted(new_text):
	var result = regex.search(new_text)
	if (result):
		print(result.get_string())
		return
	
	notice_box.dialog_text = "'" + new_text + "' is not a valid Store Name (no special characters allowed)"
	notice_box.popup_centered()


func _on_line_edit_2_text_submitted(new_text):
	var result = regex.search(new_text)
	if (result):
		print(result.get_string())
		return
	
	notice_box.dialog_text = "'" + new_text + "' is not a valid Player Name (no special characters allowed)"
	notice_box.popup_centered()


func _on_continue_pressed():
	SaveManager.game_data_dictionary["Player"]["Name"] = $Difficulty2/LineEdit2.get_text()
	SaveManager.game_data_dictionary["Store"]["Name"] = $Difficulty2/LineEdit.get_text()
	
	SaveManager.spawn_new_active_fluffy()
	SaveManager.spawn_new_active_fluffy()
	SaveManager.spawn_new_active_fluffy()
	
	get_tree().change_scene_to_file("res://MainGame.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://new_game.tscn")

