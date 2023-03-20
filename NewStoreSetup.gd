extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_location_item_selected($Difficulty2/Location.selected)
	_on_size_item_selected($Difficulty2/Size.selected)

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


func _on_line_edit_text_submitted(new_text):
	pass # Replace with function body.


func _on_line_edit_2_text_submitted(new_text):
	pass # Replace with function body.


func _on_continue_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://new_game.tscn")

