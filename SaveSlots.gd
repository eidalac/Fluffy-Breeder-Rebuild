extends ConfirmationDialog

var access_mode = "Load"
var slot_selected = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	


func _on_about_to_popup():
	title = access_mode + " Game"
	ok_button_text = access_mode
	slot_selected = -1
	
	$ColorRect/Button.text = get_time_format_string(0)
	$ColorRect/Button.button_pressed = 0
	
	$ColorRect/Button1.text = get_time_format_string(1)
	$ColorRect/Button1.button_pressed = 0
	
	$ColorRect/Button2.text = get_time_format_string(2)
	$ColorRect/Button2.button_pressed = 0
	
	$ColorRect/Button3.text = get_time_format_string(3)
	$ColorRect/Button3.button_pressed = 0
	
	$ColorRect/Button4.text = get_time_format_string(4)
	$ColorRect/Button4.button_pressed = 0
	
	$ColorRect/Button5.text = get_time_format_string(5)
	$ColorRect/Button5.button_pressed = 0
	
	$ColorRect/Button6.text = get_time_format_string(6)
	$ColorRect/Button6.button_pressed = 0
	
	$ColorRect/Button7.text = get_time_format_string(7)
	$ColorRect/Button7.button_pressed = 0
	
	$ColorRect/Button8.text = get_time_format_string(8)
	$ColorRect/Button8.button_pressed = 0
	
	$ColorRect/Button9.text = get_time_format_string(9)
	$ColorRect/Button9.button_pressed = 0
	
	
	return



func get_time_format_string(index):
	if (not SaveManager.save_game_exists(index)):
		return "Empty\n "
	
	var file_time_dictionary = Time.get_datetime_dict_from_unix_time(SaveManager.get_game_file_time_info(index))
	#var system_time_dictionary = Time.get_datetime_dict_from_system()
	var am_pm = " AM"
	var system_time_zone_dictionary
	var time_zone_hours
	var format_string = "<slot> MM/DD at HH:II"
	
	system_time_zone_dictionary = Time.get_time_zone_from_system()
	time_zone_hours = int (system_time_zone_dictionary["bias"] / 60)
	file_time_dictionary = Time.get_datetime_dict_from_unix_time(SaveManager.get_game_file_time_info(index))
	
	var test_hour = file_time_dictionary["hour"] + time_zone_hours
	
	if (test_hour < 0):
		file_time_dictionary["hour"] = 12 + test_hour
		file_time_dictionary["day"] = file_time_dictionary["day"] - 1
		am_pm = " PM"
	else:
		file_time_dictionary["hour"] = test_hour
	
	if (file_time_dictionary["hour"] > 12):
		file_time_dictionary["hour"] = file_time_dictionary["hour"] - 12
	
	format_string = format_string.replace("MM",  String.num_int64(file_time_dictionary["month"]))
	format_string = format_string.replace("DD",  String.num_int64(file_time_dictionary["day"]))
	format_string = format_string.replace("HH",  String.num_int64(file_time_dictionary["hour"]))
	format_string = format_string.replace("DD",  String.num_int64(file_time_dictionary["day"]))
	if (file_time_dictionary["minute"] < 10):
		format_string = format_string.replace("II",  "0" + String.num_int64(file_time_dictionary["minute"]) + am_pm)
	else:
		format_string = format_string.replace("II",  String.num_int64(file_time_dictionary["minute"]) + am_pm)
	format_string = format_string.replace("<slot>", SaveManager.get_game_file_name(index) + "\n")
	
	return format_string



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_confirmed():
	if (slot_selected == -1):
		return
	
	if (access_mode == "Load"):
		if (SaveManager.is_save_valid(slot_selected)):
			SaveManager.load_on_start = slot_selected
			#get_tree().change_scene_to_file("res://Game.tscn")
			get_tree().change_scene_to_file("res://MainGame.tscn")
		else:
			var notice_box = load("res://AlertBox.tscn").instantiate()
			notice_box.dialog_text = "Save file '" + String.num_int64(slot_selected) + "' version is not supported in this build."
			add_child(notice_box)
			notice_box.popup_centered()
			return
	else:
		SaveManager.save_game_data(slot_selected)
	
	hide()


func _on_button_toggled(button_pressed):
	if (SaveManager.save_game_exists() or access_mode == "Save"):
		slot_selected = 0
		return
	
	slot_selected = -1
	$ColorRect/Button.button_pressed = 0


func _on_button_1_toggled(button_pressed):
	if (SaveManager.save_game_exists(1) or access_mode == "Save"):
		slot_selected = 1
		return
	
	slot_selected = -1
	$ColorRect/Button1.button_pressed = 0


func _on_button_2_toggled(button_pressed):
	if (SaveManager.save_game_exists(2) or access_mode == "Save"):
		slot_selected = 2
		return
	
	slot_selected = -1
	$ColorRect/Button2.button_pressed = 0


func _on_button_3_toggled(button_pressed):
	if (SaveManager.save_game_exists(3)) or access_mode == "Save":
		slot_selected = 3
		return
	
	slot_selected = -1
	$ColorRect/Button3.button_pressed = 0


func _on_button_4_toggled(button_pressed):
	if (SaveManager.save_game_exists(4) or access_mode == "Save"):
		slot_selected = 4
		return
	
	slot_selected = -1
	$ColorRect/Button4.button_pressed = 0


func _on_button_5_toggled(button_pressed):
	if (SaveManager.save_game_exists(5) or access_mode == "Save"):
		slot_selected = 5
		return
	
	slot_selected = -1
	$ColorRect/Button5.button_pressed = 0


func _on_button_6_toggled(button_pressed):
	if (SaveManager.save_game_exists(6) or access_mode == "Save"):
		slot_selected = 6
		return
	
	slot_selected = -1
	$ColorRect/Button6.button_pressed = 0


func _on_button_7_toggled(button_pressed):
	if (SaveManager.save_game_exists(7) or access_mode == "Save"):
		slot_selected = 7
		return
	
	slot_selected = -1
	$ColorRect/Button7.button_pressed = 0


func _on_button_8_toggled(button_pressed):
	if (SaveManager.save_game_exists(8) or access_mode == "Save"):
		slot_selected = 8
		return
	
	slot_selected = -1
	$ColorRect/Button8.button_pressed = 0


func _on_button_9_toggled(button_pressed):
	if (SaveManager.save_game_exists(9) or access_mode == "Save"):
		slot_selected = 9
		return
	
	slot_selected = -1
	$ColorRect/Button9.button_pressed = 0

