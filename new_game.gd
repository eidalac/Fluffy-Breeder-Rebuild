extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Difficulty/SimpleButton.grab_focus()
	$Continue.disabled = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_sandbox_button_toggled(button_pressed):
	$OptionDetails.text = "Freeplay mode.\nDo whatever you want."
	$Continue.disabled = not button_pressed
	$OptionDetails2.text = ""
	
	$Difficulty2/EconmyOption.selected = 0
	$Difficulty2/AlicornOption1.selected = 0
	$Difficulty2/AlicornOption2.selected = 0
	$Difficulty2/PoopyOption.selected = 0
	$Difficulty2/SmartyOption.selected = 0


func _on_simple_button_toggled(button_pressed):
	$OptionDetails.text = "The lowest difficulty, for those who just want to have fun.\nThings will be cheaper for you to buy, you will get more money for selling fluffies and random events will be stacked in your favour."
	$Continue.disabled = not button_pressed
	$OptionDetails2.text = ""
	
	$Difficulty2/EconmyOption.selected = 0
	$Difficulty2/AlicornOption1.selected = 0
	$Difficulty2/AlicornOption2.selected = 0
	$Difficulty2/PoopyOption.selected = 0
	$Difficulty2/SmartyOption.selected = 0



func _on_easy_button_toggled(button_pressed):
	$OptionDetails.text = "For those who want some fun and risk.\nMost costs will be reduced and some events will favour you."
	$Continue.disabled = not button_pressed
	$OptionDetails2.text = ""
	
	$Difficulty2/EconmyOption.selected = 0
	$Difficulty2/AlicornOption1.selected = 1
	$Difficulty2/AlicornOption2.selected = 1
	$Difficulty2/PoopyOption.selected = 0
	$Difficulty2/SmartyOption.selected = 0


func _on_normal_button_toggled(button_pressed):
	$OptionDetails.text = "The default difficulty.\nPrices and chances are all at defaults."
	$Continue.disabled = not button_pressed
	$OptionDetails2.text = ""
	
	$Difficulty2/EconmyOption.selected = 1
	$Difficulty2/AlicornOption1.selected = 1
	$Difficulty2/AlicornOption2.selected = 1
	$Difficulty2/PoopyOption.selected = 1
	$Difficulty2/SmartyOption.selected = 1


func _on_hard_button_toggled(button_pressed):
	$OptionDetails.text = "The hardest difficulty.\nEverything will cost more, you will make less monney and luck is not on your side."
	$Continue.disabled = not button_pressed
	$OptionDetails2.text = ""
	
	$Difficulty2/EconmyOption.selected = 2
	$Difficulty2/AlicornOption1.selected = 2
	$Difficulty2/AlicornOption2.selected = 2
	$Difficulty2/PoopyOption.selected = 2
	$Difficulty2/SmartyOption.selected = 2


func _on_advanced_toggled(button_pressed):
	$Difficulty.visible = not button_pressed
	$Difficulty2.visible = button_pressed

func _on_econmy_option_pressed():
	$OptionDetails.text = "In the years since the BioToys known as Fluffies were released from HasBio labs, the world has been greatly changed by this new addition.\nThis setting is how strongly the economy has been impacted.\nAffects all prices."

func _on_alicorn_option_1_pressed():
	$OptionDetails.text = "Fluffies have four breeds.  The rarest breed is the Alicorn, having both wings and a horn.\nThis setting controls how rare (and expesnive) Alicorns are."

func _on_alicorn_option_2_pressed():
	$OptionDetails.text = "Fluffies are often fearfull or hostile to Alicorns, viewing them as monsters.\nThis setting controls how bad this hositlity is.  Increases the rarity of Alicorns."

func _on_poopy_option_pressed():
	$OptionDetails.text = "Brown colored fluffies are often rejected as so called poopy babies. \nThis setting controls how common this is and how easy it is to train a fluffy to avoid this."

func _on_smarty_option_pressed():
	$OptionDetails.text = "Smarty Friends are leaders of herds of fluffies, but sometimes these fall into extreme behaviour issues.\nThis setting controls how commong these smarties are and how easily they can be corrected."

func _on_smarty_option_item_selected(index):
	if (index == 3):
		$OptionDetails2.text = "WARNING: This setting enables extreme content."
		$OptionDetails2.modulate = Color("b4141e")
	else:
		$OptionDetails2.text = ""
		$OptionDetails2.modulate = Color("b4141e")

func _on_continue_pressed():
	var test = SaveManager.game_data_dictionary["Diffculty"]["Economy Level"]
	
	SaveManager.game_data_dictionary["Diffculty"]["Economy Level"] = $Difficulty2/EconmyOption.selected
	SaveManager.game_data_dictionary["Diffculty"]["Alicorn Rarity"] = $Difficulty2/AlicornOption1.selected
	SaveManager.game_data_dictionary["Diffculty"]["Alicorn Hate"] = $Difficulty2/AlicornOption2.selected
	SaveManager.game_data_dictionary["Diffculty"]["Brown Hate"] = $Difficulty2/PoopyOption.selected
	SaveManager.game_data_dictionary["Diffculty"]["Smarty Level"] = $Difficulty2/SmartyOption.selected
	$OptionDetails2.text = ""
	
	get_tree().change_scene_to_file("res://NewStoreSetup.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
