extends Node

class_name DataManager

const SAVE_FILE_NAME = "fluffybreeder.save"
const SAVE_FILE_DIRECTORY = "user://"
var game_data_dictionary = {}

var preloaded_fluffy
var fluffy_list = [ null, null, null ]

var load_on_start = false

var version = load("res://version.gd").VERSION

func _init():
	pass

func save_game_exists():
	return FileAccess.file_exists(SAVE_FILE_DIRECTORY+SAVE_FILE_NAME)

func load_game_data():
	if not FileAccess.file_exists(SAVE_FILE_DIRECTORY+SAVE_FILE_NAME):
		print("Save file '%s' not found." % SAVE_FILE_DIRECTORY+SAVE_FILE_NAME)
		return # Error! We don't have a save to load.
	
	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	var save_file = FileAccess.open(SAVE_FILE_DIRECTORY+SAVE_FILE_NAME, FileAccess.READ)
	
	if (save_file == null):
		print("Failed to open save file '%s'." % SAVE_FILE_DIRECTORY+SAVE_FILE_NAME)
		return
	
	game_data_dictionary = save_file.get_var()
	
	for saved_key in game_data_dictionary:
		var new_object = load(game_data_dictionary[saved_key]["filename"]).instantiate()
		get_node(game_data_dictionary[saved_key]["parent"]).add_child(new_object)
		new_object.position = Vector2(game_data_dictionary[saved_key]["pos_x"], game_data_dictionary[saved_key]["pos_y"])
		new_object.scale = Vector2(game_data_dictionary[saved_key]["scale"], game_data_dictionary[saved_key]["scale"])
		new_object.my_genome = Genome.new(game_data_dictionary[saved_key]["genome"])
		
		if (game_data_dictionary[saved_key]["name"] == "Child"):
			fluffy_list[0] = new_object
		elif (game_data_dictionary[saved_key]["name"] == "Mom"):
			fluffy_list[1] = new_object
		else:
			fluffy_list[2] = new_object

		# Now we set the remaining variables.
		for i in game_data_dictionary[saved_key].keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "scale" or i == "genome":
				continue
			new_object.set(i, game_data_dictionary[saved_key][i])
	save_file.close()
	
func save_game_data():
	var save_file = FileAccess.open(SAVE_FILE_DIRECTORY+SAVE_FILE_NAME, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var game_data_dictionary = {}
	var key = 0;
	
	for node_to_save in save_nodes:
		node_to_save.save()
		
		# Check the node is an instanced scene so it can be instanced again during load.
		if node_to_save.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node_to_save.name)
			continue
			
		# Check the node has a save function.
		if !node_to_save.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node_to_save.name)
			continue
		
		# Call the node's save function.
		game_data_dictionary.merge({key : node_to_save.call("save")})
		key += 1
		
	save_file.store_var(game_data_dictionary)
	save_file.close()

