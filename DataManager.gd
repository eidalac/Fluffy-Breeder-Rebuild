extends Node

class_name DataManager

const SAVE_FILE_NAME = "fluffybreeder.save"
const SAVE_FILE_DIRECTORY = "user://"

var default_game_data_dictionary = {
	"Version" : "v%s" % load("res://version.gd").VERSION,
	"Diffculty" : {
		"Level" : 0,
		"Economy Level" : 0,
		"Alicorn Rarity" : 0,
		"Alicorn Hate" : 0,
		"Brown Hate" : 0,
		"Smarty Level" : 0,
	},
	"Active Fluffies" : [],
	"Inactive Fluffies" : [],
	"Dead Fluffies" : [],
	"Player" : {
		"Name" : "Owner",
		"Training" : 0,
		"Abuse" : 0,
		"Hugbox" : 0,
		"Repulation" : 0,
		"Stress" : 0,
		"Energy" : 0,
		"Cash" : 0,
	},
	"Store" : {
		"Name" : "The Fluffy Shop",
		"Location" : 0,
		"Size" : 0,
		"Dispaly" : 0,
		"Storage" : 0,
		"Shelter" : 0,
	}
}

var game_data_dictionary = {}
var preloaded_fluffy
var load_on_start = -1
var inspect_mode = false

func _ready():
	game_data_dictionary = default_game_data_dictionary.duplicate(true)

func _init():
	game_data_dictionary = default_game_data_dictionary.duplicate(true)

func spawn_new_active_fluffy():
	preloaded_fluffy = preload("res://fluffy.tscn").instantiate()
	preloaded_fluffy.init()
	game_data_dictionary["Active Fluffies"].append(preloaded_fluffy)

func spawn_new_inactive_fluffy():
	preloaded_fluffy = preload("res://fluffy.tscn").instantiate()
	preloaded_fluffy.init()
	game_data_dictionary["Inactive Fluffies"].append(preloaded_fluffy)

func save_game_exists(save_slot = 0):
	var file_name = SAVE_FILE_DIRECTORY+SAVE_FILE_NAME
	
	file_name = file_name.replace(".save", String.num_int64(save_slot)+".save")
	
	return FileAccess.file_exists(file_name)

func is_save_valid(save_slot = 0):
	#return true 
	if (get_game_file_time_info(save_slot) == -1):
		return false
	
	var save_file_with_slot = SAVE_FILE_DIRECTORY+SAVE_FILE_NAME
	
	save_file_with_slot = save_file_with_slot.replace(".save", String.num_int64(save_slot)+".save")
	
	if not FileAccess.file_exists(save_file_with_slot):
		return false
	
	var save_file = FileAccess.open(save_file_with_slot, FileAccess.READ)
	
	if (save_file == null):
		print("Failed to open save file '%s'." % save_file_with_slot)
		return false
	
	game_data_dictionary = save_file.get_var()
	
	if (not game_data_dictionary.has("Version")):
		print("Save file '%s' has no version number." % save_file_with_slot)
		return false
	
	if (game_data_dictionary["Version"] != "v%s" % load("res://version.gd").VERSION):
		return false
	
	return true


func get_game_file_name(save_slot = 0):
	if (get_game_file_time_info(save_slot) == -1):
		return "Empty"
	
	var save_file_with_slot = SAVE_FILE_DIRECTORY+SAVE_FILE_NAME
	
	save_file_with_slot = save_file_with_slot.replace(".save", String.num_int64(save_slot)+".save")
	
	if not FileAccess.file_exists(save_file_with_slot):
		return "Empty"
		
	var save_file = FileAccess.open(save_file_with_slot, FileAccess.READ)
	
	if (save_file == null):
		return "ERROR"
	
	var save_game_data_dictionary = save_file.get_var()
	
	if (save_game_data_dictionary == null):
		return "ERROR"
	
	if (not save_game_data_dictionary.has("Store")):
		return "ERROR"
	
	if (not save_game_data_dictionary["Store"].has("Name")):
		return "ERROR"
	
	return save_game_data_dictionary["Store"]["Name"]

func get_game_file_time_info(save_slot = 0):
	var file_exists = false
	var file_name = SAVE_FILE_DIRECTORY+SAVE_FILE_NAME
	
	file_name = file_name.replace(".save", String.num_int64(save_slot)+".save")
	
	if (not FileAccess.file_exists(file_name)):
		return -1
	
	return FileAccess.get_modified_time(file_name)

func load_game_data(save_slot = 0):
	
	var save_file_with_slot = SAVE_FILE_DIRECTORY+SAVE_FILE_NAME
	var load_game_dictionary
	
	save_file_with_slot = save_file_with_slot.replace(".save", String.num_int64(save_slot)+".save")
	
	if not FileAccess.file_exists(save_file_with_slot):
		print("Save file '%s' not found." % save_file_with_slot)
		return # Error! We don't have a save to load.
	
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var save_file = FileAccess.open(save_file_with_slot, FileAccess.READ)
	
	if (save_file == null):
		print("Failed to open save file '%s'." % save_file_with_slot)
		return
	
	load_game_dictionary = save_file.get_var()
	
	if (not load_game_dictionary.has("Version")):
		print("Save file '%s' has no version number." % save_file_with_slot)
		var temp_dictionary = { "Version" : "v%s" % load("res://version.gd").VERSION }
		temp_dictionary.merge(load_game_dictionary)
		load_game_dictionary = temp_dictionary
	elif (load_game_dictionary["Version"] != "v%s" % load("res://version.gd").VERSION):
		var notice_box = load("res://AlertBox.tscn").instantiate()
		notice_box.dialog_text = "Save file '" + save_file_with_slot + "' is not supported in this build."
		notice_box.position = Vector2(get_viewport().get_visible_rect().size.x / 3, get_viewport().get_visible_rect().size.y / 3)
		notice_box.visible = true
		add_child(notice_box)
		return
	
	for i in save_nodes:
		i.queue_free()
	
	game_data_dictionary = default_game_data_dictionary.duplicate(true)
	
	for saved_key in load_game_dictionary:
		var new_object
		
		if (typeof(saved_key) == TYPE_STRING):
			if (saved_key == "Active Fluffies"):
				for active_fluffy in load_game_dictionary[saved_key].size():
					new_object = load("res://fluffy.tscn").instantiate()
					
					for index in load_game_dictionary[saved_key][active_fluffy].keys():
						if (index == "genome"):
							new_object.my_genome = Genome.new(load_game_dictionary[saved_key][active_fluffy]["genome"])
							new_object.update_from_genome()
							continue
						elif (index == "filename" or index == "parent" or index == "pos_x" or index == "pos_y" or index == "scale"):
							continue
						new_object.set(index, load_game_dictionary[saved_key][active_fluffy][index])
					
					game_data_dictionary[saved_key].append(new_object)
				continue
			elif (saved_key == "Inactive Fluffies"):
				#load_game_dictionary[saved_key] = []
				continue
			elif (saved_key == "Dead Fluffies"):
				#load_game_dictionary[saved_key] = []
				continue
			
		game_data_dictionary[saved_key] = load_game_dictionary[saved_key]
	
	save_file.close()


func save_game_data(save_slot = 0):
	
	var save_file_with_slot = SAVE_FILE_DIRECTORY+SAVE_FILE_NAME
	
	save_file_with_slot = save_file_with_slot.replace(".save", String.num_int64(save_slot)+".save")
	
	var save_file = FileAccess.open(save_file_with_slot, FileAccess.WRITE)
	#var save_nodes = get_tree().get_nodes_in_group("Persist")
	var save_data_dictionary = game_data_dictionary.duplicate(true)
	
	if (save_file == null):
		print("Failed to open save file '%s'." % save_file_with_slot)
		return
	
	save_data_dictionary["Active Fluffies"] = []
	save_data_dictionary["Inactive Fluffies"] = []
	save_data_dictionary["Dead Fluffies"] = []
	
	var saved_fluffy = null
	
	for active_fluffy_index in game_data_dictionary["Active Fluffies"].size():
		saved_fluffy = game_data_dictionary["Active Fluffies"][active_fluffy_index]
		#saved_fluffy = load("res://fluffy.tscn").instantiate()
		save_data_dictionary["Active Fluffies"].append(saved_fluffy.save())
	
	for active_fluffy_index in game_data_dictionary["Inactive Fluffies"].size():
		saved_fluffy = game_data_dictionary["Inactive Fluffies"][active_fluffy_index]
		save_data_dictionary["Inactive Fluffies"].append(saved_fluffy.save())
	
	for active_fluffy_index in game_data_dictionary["Dead Fluffies"].size():
		saved_fluffy =  game_data_dictionary["Dead Fluffies"][active_fluffy_index]
		save_data_dictionary["Dead Fluffies"].append(saved_fluffy.save())
		
		# Call the node's save function.
		
	save_file.store_var(save_data_dictionary)
	save_file.close()

