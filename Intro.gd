extends Node2D

var display_fluffy = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var size = get_viewport().get_visible_rect().size
	var base_fluffy = preload("res://fluffy.tscn")
	display_fluffy = base_fluffy.instantiate()

	display_fluffy.scale = Vector2(0.6, 0.6)
	display_fluffy.position = Vector2(size.x + 300, 500)
	display_fluffy.color_coat = Color("b4141e")
	display_fluffy.color_eye = Color("3764cb")
	display_fluffy.color_mane = Color("425a20")
	display_fluffy.has_horn = true
	display_fluffy.has_wings = true
	display_fluffy.gender = false
	
	var splash = $Splash/ColorRect
	$Splash.remove_child($Splash/ColorRect)
	$Splash.add_child(display_fluffy)
	$Splash.add_child(splash)
	
	$AnimationPlayer.play("Fade_In")
	await get_tree().create_timer(6).timeout
	$AnimationPlayer.play("Fade_Out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Disclamer.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (display_fluffy == null):
		return
	
	var size = get_viewport().get_visible_rect().size
	
	if (display_fluffy.position.x > size.x):
		display_fluffy.position = Vector2(display_fluffy.position.x - 2, 500)
