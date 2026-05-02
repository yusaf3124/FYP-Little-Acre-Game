extends Node2D

@export_multiline var my_text: String = "Default Text"

func _ready():
	$ColorRect/ToolTipText.text = my_text
	
	var parent_area = get_parent().get_node("Area2D")
	
	parent_area.mouse_entered.connect(_show_tip)
	parent_area.mouse_exited.connect(_hide_tip)

func _show_tip():
	visible = true

func _hide_tip():
	visible = false
	
func set_text (new_text: String):
	$ColorRect/ToolTipText.text = new_text
