extends Node

class_name Genome

const GRANDMOTHER_GENE = {
	"Gender": [1, 1],
	"Length": [0, 1, 0, 1, 0, 1],
	"Height": [0, 1, 0, 1],
	"Weight": [0, 1, 0, 1],
	"Lifespan": [0, 1, 0, 1],
	"Fertility": [0, 1, 0, 1],
	"Maturity": [0, 1, 0, 1],
	"Breed": [0, 1, 0, 1, 0, 1],
	"Coat Color": [0,1, 0,1, 0,1, 0,1, 0,1],
	"Mane Color": [0,1, 0,1, 0,1, 0,1, 0,1],
	"Eye Color": [0,1, 0,1, 0,1, 0,1, 0,1],
	"Strength": [0, 1, 0, 1],
	"Energy": [0, 1, 0, 1],
	"Charm": [0, 1, 0, 1],
	"Thinking": [0, 1, 0, 1],
	"Learning": [0, 1, 0, 1],
	"Species": 11,
	"Coat Length": [0, 1, 0, 1],
	"Coat Density": [0, 1, 0, 1],
	"Coat Curl": [0, 1, 0, 1],
	"Inbreeding": [0, 0],
}

const GRANDFATHER_GENE = {
	"Gender": [1, 0],
	"Length": [0, 1, 0, 1, 0, 1],
	"Height": [0, 1, 0, 1],
	"Weight": [0, 1, 0, 1],
	"Lifespan": [0, 1, 0, 1],
	"Fertility": [0, 1, 0, 1],
	"Maturity": [0, 1, 0, 1],
	"Breed": [0, 1, 0, 1, 0, 1],
	"Coat Color": [0,1, 0,1, 0,1, 0,1, 0,1],
	"Mane Color": [0,1, 0,1, 0,1, 0,1, 0,1],
	"Eye Color": [0,1, 0,1, 0,1, 0,1, 0,1],
	"Strength": [0, 1, 0, 1],
	"Energy": [0, 1, 0, 1],
	"Charm": [0, 1, 0, 1],
	"Thinking": [0, 1, 0, 1],
	"Learning": [0, 1, 0, 1],
	"Species": 11,
	"Coat Length": [0, 1, 0, 1],
	"Coat Density": [0, 1, 0, 1],
	"Coat Curl": [0, 1, 0, 1],
	"Inbreeding": [0, 0],
}

var genes = {}

func _init(from_gene = null):
	if (from_gene == null):
		var rng = RandomNumberGenerator.new()
		
		var temp_genes = GRANDFATHER_GENE.duplicate()
		genes = GRANDMOTHER_GENE.duplicate()
		
		genes["Inbreeding"] = [rng.randi_range(1, 200), rng.randi_range(100, 200)]
		temp_genes["Inbreeding"] = [rng.randi_range(1, 200), rng.randi_range(100, 200)]
		
		_cross_breed_genes(genes, temp_genes)
	else:
		genes = from_gene


func _cross_breed_genes(genome_one, genome_two):
	var rng = RandomNumberGenerator.new()
	var parent_genome_array = [genome_one, genome_two]
	var new_genome = genes.duplicate()
	var new_gene = []
	
	for gene in genes:
		if (gene == "Species"):
			new_genome[gene] = parent_genome_array[0][gene]
		else:

			for allele in genes[gene].size():
				if ((allele & 1) == 0):
					rng.randomize()
					var a1 = allele + rng.randi_range(0, 1)
					var a2 = allele + rng.randi_range(0, 1)
					
					new_gene.insert(0, parent_genome_array[rng.randi_range(0, 1)][gene][a1])
					new_gene.insert(1, parent_genome_array[rng.randi_range(0, 1)][gene][a2])
					
			new_genome[gene] = []
			
			for new_allele in new_gene.size():
				new_genome[gene].insert(new_allele, new_gene[new_allele])
			new_gene = []
	
	genes = new_genome
	return

func get_gender_value_from_genome():
	if (genes["Gender"] == [1, 1]):
		return true
	return false

func get_length_value_from_genome():
	var first_gene_has_at_least_one_dominant = bool(genes["Length"][0] | genes["Length"][1])
	var second_gene_has_at_least_one_dominant = bool(genes["Length"][2] | genes["Length"][3])
	var thrid_gene_has_at_least_one_dominant = bool(genes["Length"][4] | genes["Length"][5])
	var result = -1
	
	if (first_gene_has_at_least_one_dominant and second_gene_has_at_least_one_dominant):
		if (thrid_gene_has_at_least_one_dominant):
			result = 33
		else:
			result = 31
	elif (first_gene_has_at_least_one_dominant and thrid_gene_has_at_least_one_dominant):
		result = 29
	elif (second_gene_has_at_least_one_dominant and thrid_gene_has_at_least_one_dominant):
		result = 35
	elif (first_gene_has_at_least_one_dominant):
		result = 39
	elif (second_gene_has_at_least_one_dominant):
		result = 37
	elif (thrid_gene_has_at_least_one_dominant):
		result = 26
	else:
		result = 25
	
	#print("Length Gene: ", genes["Length"], " | Value: ", result)
	return result

func test_double_gene(gene_to_test):
	var first_gene_both_dominant = bool(gene_to_test[0] & gene_to_test[1])
	var second_gene_both_dominant = bool(gene_to_test[2] & gene_to_test[3])
	
	var second_gene_both_recesive = !bool(gene_to_test[2] | gene_to_test[3])

	var result = -1
	
	if (first_gene_both_dominant):
		if (second_gene_both_dominant):
			result = 1
		elif (second_gene_both_recesive):
			result = 3
		else:
			result = 2
	elif (second_gene_both_dominant):
		result = 5
	elif (second_gene_both_recesive):
		result = 0
	else:
		result = 4
	
	return result

func get_height_value_from_genome():
	var base = 0.65
	var result = float(test_double_gene(genes["Height"]))
	
	result *= 3
	result = result / 100
	result = base - result
	
	return result

func get_weight_value_from_genome():
	var base = 0.105
	var result = float(test_double_gene(genes["Weight"]))
	
	result *= 5
	result = result / 1000
	result = base - result
	return result

func get_lifespan_value_from_genome():
	return 12 - test_double_gene(genes["Lifespan"])
 
# Fertility
func get_fertility_value_from_genome():
	return 2 + test_double_gene(genes["Fertility"])

# Maturity
func get_maturity_value_from_genome():
	return 36 + (2 * test_double_gene(genes["Maturity"]))

##################################################################################################################################
##################################################################################################################################
#
# BREED CODE
#
##################################################################################################################################
##################################################################################################################################
func breed_gene_index(gene_to_test):
	var first_gene_both_dominant = bool(gene_to_test[0] & gene_to_test[1])
	var second_gene_both_dominant = bool(gene_to_test[2] & gene_to_test[3])
	var thrid_gene_both_dominant = bool(gene_to_test[4] & gene_to_test[5])
	var second_gene_both_recesive = !bool(gene_to_test[2] | gene_to_test[3])
	var thrid_gene_both_recesive = !bool(gene_to_test[4] | gene_to_test[5])
	
	var result = -1
	
	if (first_gene_both_dominant):
		if (second_gene_both_dominant):
			if (thrid_gene_both_dominant):
				result = 0
				#print("Breed Gene: ", genes["Breed"], " | Value: Earthy")
			else:
				result = 1
				#print("Breed Gene: ", genes["Breed"], " | Value: Pegasus")
		else:
			if (thrid_gene_both_dominant):
				result = 2
				#print("Breed Gene: ", genes["Breed"], " | Value: Unicorn")
			else:
				result = 0
				#print("Breed Gene: ", genes["Breed"], " | Value: Earthy")
	else:
		if (second_gene_both_dominant):
			if (thrid_gene_both_dominant):
				result = 4
				#print("Breed Gene: ", genes["Breed"], " | Value: Alicorn")
			else:
				result = 1
				#print("Breed Gene: ", genes["Breed"], " | Value: Pegasus")
		else:
			if (thrid_gene_both_dominant):
				result = 2
				#print("Breed Gene: ", genes["Breed"], " | Value: Unicorn")
			elif (second_gene_both_recesive && thrid_gene_both_recesive):
				result = 3
				#print("Breed Gene: ", genes["Breed"], " | Value: possible Alicorn")
			else:
				result = 4
				#print("Breed Gene: ", genes["Breed"], " | Value: Alicorn")
	return result


func get_breed_from_geneom():
	var result = breed_gene_index(genes["Breed"])
	#print("Breed Gene: ", genes["Breed"], " | Value: ", result)
	return result

##################################################################################################################################
##################################################################################################################################
#
# COLOR CODE
#
##################################################################################################################################
##################################################################################################################################
func color_gene_index(color_gene, white_gene):
	var result = -1
	if (color_gene[0] & color_gene[1]):
		if (white_gene[0] & white_gene[1]):
			result = 8
		elif (white_gene[0] ^ white_gene[1]):
			result = 7
		else:
			result = 6
	elif (color_gene[0] ^ color_gene[1]):
		if (white_gene[0] & white_gene[1]):
			result = 5
		elif (white_gene[0] ^ white_gene[1]):
			result = 4
		else:
			result = 3
	else:
		if (color_gene[0] & white_gene[1]):
			result = 2
		elif (white_gene[0] ^ white_gene[1]):
			result = 1
		else:
			result = 0
	
	return (result * 28)

# "Coat Color": [0,1, 0,1, 0,1, 0,1, 0,1],
func test_color_gene(gene_to_test):
	var white_gene = [gene_to_test[8], gene_to_test[9]]
	
	var blue_gene = [gene_to_test[0], gene_to_test[1]]
	var yellow_gene = [gene_to_test[2], gene_to_test[3]]
	var red_gene = [gene_to_test[4], gene_to_test[5]]
	var orange_gene = [gene_to_test[6], gene_to_test[7]]
	
	var blue_value = color_gene_index(blue_gene, white_gene)
	var yellow_value = color_gene_index(yellow_gene, white_gene)
	var red_value = color_gene_index(red_gene, white_gene)
	
	if (orange_gene[0] == 0 && orange_gene[1] == 0):
		blue_value = clamp(blue_value * 0.90, 0, 255)
		yellow_value = clamp(yellow_value * 1.5, 0, 255)
		red_value = clamp(red_value * 0.70, 0, 255)
	elif (orange_gene[0] == 0 || orange_gene[1] == 0):
		blue_value = clamp(blue_value * 1.45, 0, 255)
		yellow_value = clamp(yellow_value * 1.6, 0, 255)
		red_value = clamp(red_value * 1.3, 0, 255)
	else:
		blue_value = clamp(blue_value * 1.9, 0, 255)
		yellow_value = clamp(yellow_value * 1.7, 0, 255)
		red_value = clamp(red_value * 1.4, 0, 255)
	
	var color_string = "#"
	
	if (blue_value < 15):
		color_string += "0"
	color_string += String.num_int64(blue_value, 16, true) 
	if (yellow_value < 15):
		color_string += "0"
	color_string += String.num_int64(yellow_value, 16, true) 
	if (red_value < 15):
		color_string += "0"
	color_string += String.num_int64(red_value, 16, true) 
	
	return color_string



func get_coat_color_from_gennome():
	var result = test_color_gene(genes["Coat Color"])
	#print("Coat Color Gene: ", genes["Coat Color"], " | Value: ", result)
	return result

func get_mane_color_from_gennome():
	var result = test_color_gene(genes["Mane Color"])
	#print("Mane Color Gene: ", genes["Mane Color"], " | Value: ", result)
	return result

func get_eye_color_from_gennome():
	var result = test_color_gene(genes["Eye Color"])
	#print("Eye Color Gene: ", genes["Eye Color"], " | Value: ", result)
	return result

##################################################################################################################################
##################################################################################################################################
#
# STATS
#
##################################################################################################################################
func get_strength_value_from_genome():
	return int(test_double_gene(genes["Strength"]) + 1)

func get_energy_value_from_genome():
	return int(test_double_gene(genes["Energy"]) + 1)

func get_charm_value_from_genome():
	return int(test_double_gene(genes["Charm"]) + 1)

func get_thinking_value_from_genome():
	return int(test_double_gene(genes["Thinking"]) + 1)

func get_learning_value_from_genome():
	return int(test_double_gene(genes["Learning"]) + 1)

func get_subspecies_from_genome():
	return (genes["Species"] / 19)

	#"Coat Length": [0, 1, 0, 1],
func get_coat_length_value_from_genome():
	return 1 + (test_double_gene(genes["Coat Length"]) * 2)

	#"Coat Density": [0, 1, 0, 1],
func get_coat_density_value_from_genome():
	return 40 + (test_double_gene(genes["Coat Density"]) * 30)

	#"Coat Curl": [0, 1, 0, 1],
func get_coat_curl_value_from_genome():
	return test_double_gene(genes["Coat Curl"])

	#"Inbreeding": [0, 0],
func get_inbreeding_value_from_genome():
	return (genes["Inbreeding"][0] == genes["Inbreeding"][1])

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
