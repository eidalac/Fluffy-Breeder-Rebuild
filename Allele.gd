extends Node

class_name Allele

var nucleotide

func _init(nucleotide_base):
	set_nucleotide(nucleotide_base)

func set_nucleotide(nucleotide_base):
	nucleotide_base = String(nucleotide_base)
	
	if (nucleotide_base.length() == 0):
		return
	
	nucleotide = String(nucleotide_base.substr(0, 1))

func get_nucleotide():
	return nucleotide


func _ready():
	pass # Replace with function body.



func _process(delta):
	pass
