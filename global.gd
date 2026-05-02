extends Node

var plantselected = 1 #1 = wheat, #2 = tomato, #3 = sugarcane, #4 = corn, #5 = potato, #6=hotpepper
var coins = 0
var dragging_seedpack = false

var max_harvest_capacity = 12
var reserved_crop_slots = 0
var capacity_label = null

var unlocked_crops = [1, 2]

var plots = {
	"unitedkingdomplot": {
		"name": "United Kingdom",
		"water": "medium", "temp": "mild", "soil": "loamy", "nutrients": "medium"
	},
	"italyplot": {
		"name": "Italy",
		"water": "medium", "temp": "warm", "soil": "loamy", "nutrients": "high"
	},
	"brazilplot": {
		"name": "Brazil",
		"water": "high", "temp": "hot", "soil": "loamy", "nutrients": "high"
	},
	"mexicoplot": {
		"name": "Mexico",
		"water": "medium", "temp": "warm", "soil": "clay", "nutrients": "medium"
	},
	"peruplot": {
		"name": "Peru",
		"water": "medium", "temp": "cool", "soil": "sandy", "nutrients": "medium"
	},
	"indiaplot": {
		"name": "India",
		"water": "low", "temp": "warm", "soil": "sandy", "nutrients": "high"
	}
}

var crops = {
	1: { 
		"name": "Wheat",
		"water": "medium", "temp": "mild", "soil": "loamy", "nutrients": "medium",
		"base_value": 15
	},
	2: { 
		"name": "Tomato",
		"water": "medium", "temp": "warm", "soil": "loamy", "nutrients": "high",
		"base_value": 20
	},
	3: { 
		"name": "Sugarcane",
		"water": "high", "temp": "hot", "soil": "loamy", "nutrients": "high",
		"base_value": 25
	},
	4: { 
		"name": "Corn",
		"water": "medium", "temp": "warm", "soil": "clay", "nutrients": "medium",
		"base_value": 18
	},
	5: { 
		"name": "Potato",
		"water": "medium", "temp": "cool", "soil": "sandy", "nutrients": "medium",
		"base_value": 17
	},
	6: { 
		"name": "Hot Pepper",
		"water": "low", "temp": "warm", "soil": "sandy", "nutrients": "high",
		"base_value": 22
	}
}

var harvest_inventory = []

var quiz_questions = [
	
	{
		"question": "Which food is most traditionally associated with wheat consumption in the United Kingdom?",
		"answers": ["Bread", "Porridge", "Pastries"],
		"correct": "Bread",
		"crop_id": 1
	},
	{
		"question": "In which region is most of the United Kingdom’s farmland concentrated?",
		"answers": ["Eastern England", "Northern Scotland", "Southwest England"],
		"correct": "Eastern England",
		"crop_id": 1

	},
	{
		"question": "Why is wheat economically important in the United Kingdom?",
		"answers": [
			"It supports livestock feed and food production",
			"It is mainly exported as raw fibre",
			"It is only grown for biofuel"
		],
		"correct": "It supports livestock feed and food production",
		"crop_id": 1
	},

	
	{
		"question": "Which Italian dish commonly uses tomatoes as a key base ingredient?",
		"answers": ["Pasta al pomodoro", "Risotto alla milanese", "Polenta"],
		"correct": "Pasta al pomodoro",
		"crop_id": 2
	},
	{
		"question": "Which part of Italy is especially known for large scale tomato production?",
		"answers": ["Northern Alps", "Southern regions", "Sardinia only"],
		"correct": "Southern regions",
		"crop_id": 2
	},
	{
		"question": "Why are tomatoes economically important in Italy?",
		"answers": [
			"They are widely used in processed foods like sauces",
			"They are mainly used for animal feed",
			"They are primarily grown for export as fresh fruit only"
		],
		"correct": "They are widely used in processed foods like sauces",
		"crop_id": 2
	},

	
	{
		"question": "What is sugarcane primarily processed into in Brazil?",
		"answers": ["Sugar", "Ethanol fuel", "Molasses"],
		"correct": "Sugar",
		"crop_id": 3
	},
	{
		"question": "Which region of Brazil is most associated with sugarcane production?",
		"answers": ["Amazon rainforest", "Central South region", "Southern mountains"],
		"correct": "Central South region",
		"crop_id": 3
	},
	{
		"question": "Besides sugar, what is another major economic use of sugarcane in Brazil?",
		"answers": ["Ethanol fuel", "Animal feed production", "Paper manufacturing"],
		"correct": "Ethanol fuel",
		"crop_id": 3
	},

	
	{
		"question": "Which traditional Mexican food is primarily made from corn?",
		"answers": ["Tortillas", "Tamales", "Arepas"],
		"correct": "Tortillas",
		"crop_id": 4
	},
	{
		"question": "Corn was first domesticated in which region?",
		"answers": ["Central America", "South America", "North America"],
		"correct": "Central America",
		"crop_id": 4
	},
	{
		"question": "Why is corn important in Mexico’s economy and culture?",
		"answers": [
			"It is a staple food and cultural symbol",
			"It is mainly used for decoration",
			"It is rarely consumed",
			
		],
		"correct": "It is a staple food and cultural symbol",
		"crop_id": 4
	},

	
	{
		"question": "Which civilisation is known for early potato cultivation?",
		"answers": ["Inca", "Aztec", "Maya"],
		"correct": "Inca",
		"crop_id": 5
	},
	{
		"question": "Potatoes originally come from which region?",
		"answers": ["Andean highlands", "Central America", "Mediterranean region"],
		"correct": "Andean highlands",
		"crop_id": 5
	},
	{
		"question": "Why are potatoes important globally?",
		"answers": [
			"They are a high calorie staple crop",
			"They are mainly used for industrial starch production",
			"They are primarily grown for export luxury markets"
		],
		"correct": "They are a high calorie staple crop",
		"crop_id": 5
	},

	
	{
		"question": "Chilli peppers were introduced to India through trade from which region?",
		"answers": ["The Americas", "Southeast Asia", "The Middle East"],
		"correct": "The Americas",
		"crop_id": 6
	},
	{
		"question": "Which sector relies heavily on chilli pepper production in India?",
		"answers": ["Spice industry", "Food processing industry", "Pharmaceutical industry"],
		"correct": "Spice industry",
		"crop_id": 6
	},
	{
		"question": "Why are chilli peppers economically important in India?",
		"answers": [
			"They are widely exported and used domestically",
			"They are mainly consumed only in rural areas",
			"They are grown primarily for decorative purposes"
		],
		"correct": "They are widely exported and used domestically",
		"crop_id": 6
	}
]

func update_capacity_ui():
	if capacity_label == null:
		return
	
	var current = reserved_crop_slots
	var max = max_harvest_capacity
	
	if current >= max:
		capacity_label.text = "Storage Full! - Harvest & Sell Crops To Continue!"
	else:
		capacity_label.text = "Harvest Storage: " + str(current) + " / " + str(max)
