extends StaticBody2D

var feedback_pages = []
var current_page = 0
var pending_coins = 0

func _ready() -> void:
	$FeedbackUI.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player_sell_method"):
		
		if Global.harvest_inventory.size() == 0:
			return
			
		var grouped_crops = {}
		for item in Global.harvest_inventory:
			var combo_key = str(item["crop_id"]) + "_" + item["plot_id"]
			if grouped_crops.has(combo_key):
				grouped_crops[combo_key]["amount"] += 1
			else:
				grouped_crops[combo_key] = {
					"crop_id": item["crop_id"],
					"plot_id": item["plot_id"],
					"amount": 1
				}
				
		feedback_pages = grouped_crops.values()
		current_page = 0
		pending_coins = 0
		
		show_page()

func show_page() -> void:
	var group = feedback_pages[current_page]
	var crop = Global.crops[group["crop_id"]]
	var plot = Global.plots[group["plot_id"]]
	var amount = group["amount"]
	
	var score = 0
	var feedback = ""
	
	if crop["water"] == plot["water"]:
		score += 1
		feedback += "[color=lightgreen]✔ Water: Perfect (" + crop["water"].capitalize() + ")[/color]\n"
	else:
		feedback += "[color=lightcoral]✘ Water: Needs " + crop["water"].capitalize() + " (Plot is " + plot["water"].capitalize() + ")[/color]\n"
		
	if crop["temp"] == plot["temp"]:
		score += 1
		feedback += "[color=lightgreen]✔ Temp: Perfect (" + crop["temp"].capitalize() + ")[/color]\n"
	else:
		feedback += "[color=lightcoral]✘ Temp: Needs " + crop["temp"].capitalize() + " (Plot is " + plot["temp"].capitalize() + ")[/color]\n"
		
	if crop["soil"] == plot["soil"]:
		score += 1
		feedback += "[color=lightgreen]✔ Soil: Perfect (" + crop["soil"].capitalize() + ")[/color]\n"
	else:
		feedback += "[color=lightcoral]✘ Soil: Needs " + crop["soil"].capitalize() + " (Plot is " + plot["soil"].capitalize() + ")[/color]\n"
		
	if crop["nutrients"] == plot["nutrients"]:
		score += 1
		feedback += "[color=lightgreen]✔ Nutrients: Perfect (" + crop["nutrients"].capitalize() + ")[/color]\n"
	else:
		feedback += "[color=lightcoral]✘ Nutrients: Needs " + crop["nutrients"].capitalize() + " (Plot is " + plot["nutrients"].capitalize() + ")[/color]\n"
		
	var quality = "Poor"
	if score == 4:
		quality = "Excellent"
	elif score == 3:
		quality = "Good"
	elif score == 2:
		quality = "Fair"
	
	var multiplier: float = float(score) / 4.0
	var coins_per_crop = round(crop["base_value"] * multiplier)
	var group_coins = coins_per_crop * amount
	
	pending_coins += group_coins
	
	var final_text = str(amount) + "x " + crop["name"] + " Sold!\n"
	final_text += "Plot: " + plot["name"] + "\n"
	final_text += "Quality: " + quality + "\n"
	final_text += "Coins earned: " + str(group_coins) + " (" + str(coins_per_crop) + " each)\n\n"
	final_text += feedback
	
	$FeedbackUI/VBoxContainer/RichTextLabel.text = final_text
	$FeedbackUI.visible = true
	
	if current_page < feedback_pages.size() - 1:
		$FeedbackUI/VBoxContainer/Button.text = "Next Item ->"
	else:
		$FeedbackUI/VBoxContainer/Button.text = "Collect Coins & Close"

func _on_button_pressed() -> void:
	if current_page < feedback_pages.size() - 1:
		current_page += 1
		show_page() 
	else:
		Global.coins += pending_coins
		Global.reserved_crop_slots -= Global.harvest_inventory.size()
		Global.harvest_inventory.clear()
		Global.update_capacity_ui()
		$FeedbackUI.visible = false
