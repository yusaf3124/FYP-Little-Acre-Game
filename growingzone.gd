extends StaticBody2D

var plant = 0
var plantgrowing = false
var plantgrown = false

func _physics_process(delta: float) -> void:
	if !plantgrowing:
		plant = Global.plantselected


func _on_area_2d_area_entered(area: Area2D) -> void:
	if not plantgrowing:
		
		if Global.reserved_crop_slots >= Global.max_harvest_capacity:
			return
		
		if plant == 1:
			start_growth("wheatgrowing", $wheatgrowtimer)

		elif plant == 2:
			start_growth("tomatogrowing", $tomatogrowtimer)

		elif plant == 3:
			start_growth("sugarcanegrowing", $sugarcanegrowtimer)

		elif plant == 4:
			start_growth("corngrowing", $corngrowtimer)

		elif plant == 5:
			start_growth("potatogrowing", $potatogrowtimer)

		elif plant == 6:
			start_growth("hotpeppergrowing", $hotpeppergrowtimer)

	else:
		pass


func start_growth(animation_name: String, timer: Timer) -> void:
	plantgrowing = true
	plantgrown = false
	$plant.visible = true
	$plant.play(animation_name)
	$plant.frame = 0
	timer.start()
	
	Global.reserved_crop_slots += 1
	Global.update_capacity_ui()


func advance_growth(timer: Timer) -> void:
	if $plant.frame == 0:
		$plant.frame = 1
		timer.start()
	elif $plant.frame == 1:
		$plant.frame = 2
		plantgrown = true


func _on_wheatgrowtimer_timeout() -> void:
	advance_growth($wheatgrowtimer)

func _on_tomatogrowtimer_timeout() -> void:
	advance_growth($tomatogrowtimer)

func _on_sugarcanegrowtimer_timeout() -> void:
	advance_growth($sugarcanegrowtimer)

func _on_corngrowtimer_timeout() -> void:
	advance_growth($corngrowtimer)

func _on_potatogrowtimer_timeout() -> void:
	advance_growth($potatogrowtimer)

func _on_hotpeppergrowtimer_timeout() -> void:
	advance_growth($hotpeppergrowtimer)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		if plantgrown:
			
			var my_plot_id = get_parent().plot_id
			
			var harvest_data = {
				"crop_id": plant,
				"plot_id": my_plot_id
			}
			
			Global.harvest_inventory.append(harvest_data)

			clear_growing_zone()


func clear_growing_zone() -> void:
	plantgrowing = false
	plantgrown = false
	plant = 0
	
	$wheatgrowtimer.stop()
	$tomatogrowtimer.stop()
	$sugarcanegrowtimer.stop()
	$corngrowtimer.stop()
	$potatogrowtimer.stop()
	$hotpeppergrowtimer.stop()
	
	$plant.stop()
	$plant.frame = 0
	$plant.visible = false
	
func show_capacity_warning():
	if Global.capacity_label != null:
		Global.capacity_label.text = "Capacity full! Sell crops to continue."
		Global.capacity_label.visible = true
		
		await get_tree().create_timer(1.5).timeout
		
		Global.capacity_label.visible = false
