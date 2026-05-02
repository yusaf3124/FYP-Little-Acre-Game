extends StaticBody2D

func _ready() -> void:
	$"shop menu".visible = false
	
	$wheatseedpack.visible = true
	$tomatoseedpack.visible = false
	$sugarcaneseedpack.visible = false
	$cornseedpack.visible = false
	$potatoseedpack.visible = false
	$hotpepperseedpack.visible = false


func _process(delta: float) -> void:
	if $"shop menu".items[1]["owned"] == true:
		$wheatseedpack.visible = true
		
	if $"shop menu".items[2]["owned"] == true:
		$tomatoseedpack.visible = true
		
	if $"shop menu".items[3]["owned"] == true:
		$sugarcaneseedpack.visible = true
		
	if $"shop menu".items[4]["owned"] == true:
		$cornseedpack.visible = true
		
	if $"shop menu".items[5]["owned"] == true:
		$potatoseedpack.visible = true
		
	if $"shop menu".items[6]["owned"] == true:
		$hotpepperseedpack.visible = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player_shop_method"):
		$"shop menu".visible = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("player_shop_method"):
		$"shop menu".visible = false
