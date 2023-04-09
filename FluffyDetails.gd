extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var Parent_Panel = get_parent()
	var Parent_Label  = Parent_Panel.get_parent()
	var Parent_Shape = Parent_Label.get_parent()
	var Parent_Fluffy = Parent_Shape.get_parent()
	var collision_size = Parent_Shape.shape.get_rect().size
	collision_size.x = (collision_size.x * Parent_Fluffy.scale.x) / 2
	collision_size.y = (collision_size.y * Parent_Fluffy.scale.y) / 2
	
	#Parent_Panel.position = Vector2(collision_size.x - 300, collision_size.y - 200 )
	#Parent_Panel.popup(Rect2i(global_position.x - collision_size.x - 300, global_position.y - collision_size.y - 150, 300, 300))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
