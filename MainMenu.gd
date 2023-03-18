extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	
	$VBoxContainer/LoadButton.disabled = not SaveManager.save_game_exists()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")


func _on_option_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()


func _on_load_button_pressed():
	SaveManager.load_on_start = true
	get_tree().change_scene_to_file("res://Game.tscn")
	pass
