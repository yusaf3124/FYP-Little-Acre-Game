extends Control

var item = 1

var items = {
	1: {
		"name": "Wheat Seed Pack",
		"price": 0,
		"owned": true,
		"animation": "wheatseedpack"
	},
	2: {
		"name": "Tomato Seed Pack",
		"price": 0,
		"owned": true,
		"animation": "tomatoseedpack"
	},
	3: {
		"name": "Sugarcane Seed Pack",
		"price": 150,
		"owned": false,
		"animation": "sugarcaneseedpack"
	},
	4: {
		"name": "Corn Seed Pack",
		"price": 110,
		"owned": false,
		"animation": "cornseedpack"
	},
	5: {
		"name": "Potato Seed Pack",
		"price": 130,
		"owned": false,
		"animation": "potatoseedpack"
	},
	6: {
		"name": "Hot Pepper Seed Pack",
		"price": 140,
		"owned": false,
		"animation": "hotpepperseedpack"
	}
}

func _ready() -> void:
	update_shop_ui()


func _physics_process(delta: float) -> void:
	if self.visible:
		update_shop_ui()


func update_shop_ui() -> void:
	var current_item = items[item]
	
	$seedpackicon.play(current_item["animation"])
	$pricelabel.text = str(current_item["price"])
	
	if current_item["owned"]:
		$BuyButtonText.text = "Owned"
		$buybuttoncolour.color = Color("ff00007d")

	elif Global.coins >= current_item["price"]:
		$BuyButtonText.text = "Buy \n(" + str(current_item["price"]) + " coins)"
		$buybuttoncolour.color = Color("00ff007d")

	else:
		$BuyButtonText.text = "Need " + str(current_item["price"]) + "\ncoins"
		$buybuttoncolour.color = Color("ff00007d")


func _on_button_left_pressed() -> void:
	swap_item_back()


func _on_button_right_pressed() -> void:
	swap_item_forward()


func _on_buybutton_pressed() -> void:
	var current_item = items[item]
	
	if Global.coins >= current_item["price"] and current_item["owned"] == false:
		buy()


func swap_item_back() -> void:
	item -= 1
	if item < 1:
		item = items.size()


func swap_item_forward() -> void:
	item += 1
	if item > items.size():
		item = 1


func buy() -> void:
	Global.coins -= items[item]["price"]
	items[item]["owned"] = true
	update_shop_ui()
	
	if item not in Global.unlocked_crops:
		Global.unlocked_crops.append(item)
