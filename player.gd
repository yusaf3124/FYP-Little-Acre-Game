extends CharacterBody2D

var speed = 50

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("sidewalk")
		$AnimatedSprite2D.flip_h = true
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("sidewalk")
		$AnimatedSprite2D.flip_h = false
		velocity.x = -speed
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("downwalk")
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite2D.play("upwalk")
		velocity.y = -speed
	else:
		$AnimatedSprite2D.play("idle")
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func player_sell_method():
	pass
	
func player_shop_method():
	pass
