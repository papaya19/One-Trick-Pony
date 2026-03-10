extends Area2D

func _ready() -> void:
	$".".scale = Vector2(1,1)#tweeningb
	await get_tree().create_timer(0.1).timeout
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(1).timeout
	queue_free()

func _on_area_entered(body):
	if body.is_in_group("player"):
		Global.player_take_damage.emit(1)
	if body.is_in_group("enemy"):
		pass
