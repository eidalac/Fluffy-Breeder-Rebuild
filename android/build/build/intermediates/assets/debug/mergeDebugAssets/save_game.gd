class_name SaveGame
extends Resource

const SAVE_GAME_PATH := "user://fb_save.tres"

#export var character: Resource = preload("default_charcter.tres")
#export var inventory: Resource

func write_save() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)
	
static func load_save() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
