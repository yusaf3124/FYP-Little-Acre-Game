extends Area2D

var current_q = {}

func _ready() -> void:
	$QuizUI.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		
		var available_questions = []

		for q in Global.quiz_questions:
			if q["crop_id"] in Global.unlocked_crops:
				available_questions.append(q)

		if available_questions.size() == 0:
			$QuizUI.visible = true
			$QuizUI/VBoxContainer/ResultText.text = "0 crop topics unlocked.\nBuy seed packs to unlock quiz questions."
			return

		current_q = available_questions.pick_random()
		
		$QuizUI/VBoxContainer/QuestionText.text = current_q["question"]
		$QuizUI/VBoxContainer/Btn1.text = current_q["answers"][0]
		$QuizUI/VBoxContainer/Btn2.text = current_q["answers"][1]
		$QuizUI/VBoxContainer/Btn3.text = current_q["answers"][2]
		
		$QuizUI/VBoxContainer/ResultText.text = "Quiz Topics Unlocked: " + str(Global.unlocked_crops.size()) + " / 6"
		
		$QuizUI/VBoxContainer/Btn1.visible = true
		$QuizUI/VBoxContainer/Btn2.visible = true
		$QuizUI/VBoxContainer/Btn3.visible = true
		
		$QuizUI.visible = true

func _on_btn_1_pressed() -> void:
	check_answer($QuizUI/VBoxContainer/Btn1.text)

func _on_btn_2_pressed() -> void:
	check_answer($QuizUI/VBoxContainer/Btn2.text)

func _on_btn_3_pressed() -> void:
	check_answer($QuizUI/VBoxContainer/Btn3.text)

func _on_close_btn_pressed() -> void:
	$QuizUI.visible = false

func check_answer(player_guess: String) -> void:
	if player_guess == current_q["correct"]:
		$QuizUI/VBoxContainer/ResultText.text = "Correct! +10 Bonus Coins!"
		Global.coins += 10
	else:
		$QuizUI/VBoxContainer/ResultText.text = "Incorrect! The answer was: " + current_q["correct"]
		
	if Global.unlocked_crops.size() == 6:
		$QuizUI/VBoxContainer/ResultText.text += "\nAll crop topics unlocked!"
	else:
		$QuizUI/VBoxContainer/ResultText.text += "\nBuy more seed packs to unlock more quiz topics."

		
	$QuizUI/VBoxContainer/Btn1.visible = false
	$QuizUI/VBoxContainer/Btn2.visible = false
	$QuizUI/VBoxContainer/Btn3.visible = false
