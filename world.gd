extends Node2D

func _ready():
	Global.capacity_label = $CapacityWarning
	Global.update_capacity_ui()

func _physics_process(delta: float) -> void:
	var wheat_count = 0
	var tomato_count = 0
	var sugarcane_count = 0
	var corn_count = 0
	var potato_count = 0
	var hotpepper_count = 0
	
	for item in Global.harvest_inventory:
		if item["crop_id"] == 1:
			wheat_count += 1
		elif item["crop_id"] == 2:
			tomato_count += 1
		elif item["crop_id"] == 3:
			sugarcane_count += 1
		elif item["crop_id"] == 4:
			corn_count += 1
		elif item["crop_id"] == 5:
			potato_count += 1
		elif item["crop_id"] == 6:
			hotpepper_count += 1
			
	$wheattext.text = "x " + str(wheat_count)
	$tomatotext.text = "x " + str(tomato_count)
	$sugarcanetext.text = "x " + str(sugarcane_count)
	$corntext.text = "x " + str(corn_count)
	$potatotext.text = "x " + str(potato_count)
	$hotpeppertext.text = "x " + str(hotpepper_count)
	
	$cointext.text = "= " + str(Global.coins)
