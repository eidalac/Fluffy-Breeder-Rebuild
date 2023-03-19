extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/ContinueButton.grab_focus()
	var window_size = get_viewport().get_visible_rect().size
	var base_fluffy = preload("res://fluffy.tscn")
	var display_fluffy = base_fluffy.instantiate()

	display_fluffy.scale = Vector2(0.6, 0.6)
	display_fluffy.position = Vector2(window_size.x, 500)
	display_fluffy.color_coat = Color("b4141e")
	display_fluffy.color_eye = Color("3764cb")
	display_fluffy.color_mane = Color("425a20")
	display_fluffy.has_horn = true
	display_fluffy.has_wings = true
	display_fluffy.gender = false

	add_child(display_fluffy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()


func _on_continue_button_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")
