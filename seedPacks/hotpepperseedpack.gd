extends StaticBody2D

var selected = false
var seedtype = 6 #hotpepper
var home_position: Vector2

func _ready():
	$AnimatedSprite2D.play("default")
	z_index = 100
	home_position = global_position

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		Global.plantselected = seedtype
		selected = true
		Global.dragging_seedpack = true
		z_index = 110
		$SimpleToolTip.visible = false

func _physics_process(delta: float) -> void:
	if Global.dragging_seedpack:
		$SimpleToolTip.visible = false
		
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		$SimpleToolTip.visible = false
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			Global.dragging_seedpack = false
			z_index = 100
			global_position = home_position

func _on_area_2d_mouse_entered() -> void:
	if not selected:
		z_index = 105
	$SimpleToolTip.visible = true

func _on_area_2d_mouse_exited() -> void:
	if not selected:
		z_index = 100
	$SimpleToolTip.visible = false
