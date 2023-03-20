extends Node

class_name DataManager

const SAVE_FILE_NAME = "fluffybreeder.save"
const SAVE_FILE_DIRECTORY = "user://"

var default_game_data_dictionary = {
	"Version" : "v%s" % load("res://version.gd").VERSION,
	"Diffculty" : {
		"Economy Level" : 0,
		"Alicorn Rarity" : 0,
		"Alicorn Hate" : 0,
		"Brown Hate" : 0,
		"Smarty Level" : 0
	},
	"Active Fluffies" : [],
	"Inactive Fluffies" : [],
	"Dead Fluffies" : []
}

var game_data_dictionary = {}
var preloaded_fluffy
var load_on_start = false

func _ready():
	game_data_dictionary = default_game_data_dictionary

func _init():
	game_data_dictionary = default_game_data_dictionary

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
	var save_file = FileAccess.open(SAVE_FILE_DIRECTORY+SAVE_FILE_NAME, FileAccess.READ)
	
	if (save_file == null):
		print("Failed to open save file '%s'." % SAVE_FILE_NAME)
		return
	
	game_data_dictionary = save_file.get_var()
	
	if (not game_data_dictionary.has("Version")):
		print("Save file '%s' has no version number." % SAVE_FILE_NAME)
		var temp_dictionary = { "Version" : "v%s" % load("res://version.gd").VERSION }
		temp_dictionary.merge(game_data_dictionary)
		game_data_dictionary = temp_dictionary
		#return
	
	for i in save_nodes:
		i.queue_free()
	
	var keys_to_purge = []
	
	for saved_key in game_data_dictionary:
		var new_object
		
		if (typeof(saved_key) == TYPE_STRING):
			if (saved_key == "Version"):
				if (game_data_dictionary["Version"] != "v%s" % load("res://version.gd").VERSION):
					print("Save file '%s' version number does not match." % SAVE_FILE_NAME)
					game_data_dictionary[saved_key] == "v%s" % load("res://version.gd").VERSION
			elif (saved_key == "Active Fluffies"):
				#
				continue
			elif (saved_key == "Inactive Fluffies"):
				#game_data_dictionary[saved_key] = []
				continue
			elif (saved_key == "Dead Fluffies"):
				#game_data_dictionary[saved_key] = []
				continue
			continue
		else:
			new_object = load(game_data_dictionary[saved_key]["filename"]).instantiate()
			get_node(game_data_dictionary[saved_key]["parent"]).add_child(new_object)
			new_object.position = Vector2(game_data_dictionary[saved_key]["pos_x"], game_data_dictionary[saved_key]["pos_y"])
			new_object.scale = Vector2(game_data_dictionary[saved_key]["scale"], game_data_dictionary[saved_key]["scale"])
			
			if (new_object is Fluffy):
				new_object.my_genome = Genome.new(game_data_dictionary[saved_key]["genome"])
				new_object.update_from_genome()
				if (game_data_dictionary[saved_key]["name"] == "Child"):
					game_data_dictionary["Active Fluffies"].push_front(new_object);
				elif (game_data_dictionary[saved_key]["name"] == "Mom"):
					game_data_dictionary["Active Fluffies"].append(new_object);
				else:
					game_data_dictionary["Active Fluffies"].append(new_object);
				keys_to_purge.append(saved_key)
				continue
			else:
				# Now we set the remaining variables.
				for i in game_data_dictionary[saved_key].keys():
					if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "scale":
						continue
					new_object.set(i, game_data_dictionary[saved_key][i])
	
	for purge_key in keys_to_purge:
		game_data_dictionary.erase(purge_key)
	
	save_file.close()
	
func save_game_data():
	var save_file = FileAccess.open(SAVE_FILE_DIRECTORY+SAVE_FILE_NAME, FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var key = 0;
	var save_data_dictionary = game_data_dictionary.duplicate()
	
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
		
		save_data_dictionary["Active Fluffies"] = []
		save_data_dictionary["Inactive Fluffies"] = []
		save_data_dictionary["Dead Fluffies"] = []
		
		# Call the node's save function.
		save_data_dictionary.merge({key : node_to_save.call("save")})
		key += 1
		
	save_file.store_var(save_data_dictionary)
	save_file.close()

