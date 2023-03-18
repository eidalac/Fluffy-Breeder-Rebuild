extends Node

class_name Gene

var nucleotides = {}

func _init(alleles):
	set_alleles_from_one_string(alleles)

func set_alleles_from_two_strings(allele_one, allele_two):
	allele_one = String(allele_one)
	allele_two = String(allele_two)
	
	if (allele_one.length() == 0 or allele_one.length() == 0):
		return
	
	nucleotides["One"] = allele_one.substr(0, 1)
	nucleotides["Two"] = allele_two.substr(0, 1)

func set_alleles_from_one_string(alleles):
	alleles = String(alleles)
	
	if (alleles.length() == 0 or alleles.length() != 2):
		return
	
	nucleotides["One"] = alleles.substr(0, 1)
	nucleotides["Two"] = alleles.substr(1, 2)

func get_both_alleles():
	return String(nucleotides["One"] + nucleotides["Two"])

func get_allele_one():
	return String(nucleotides["One"])

func get_allele_two():
	return String(nucleotides["Two"])


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
