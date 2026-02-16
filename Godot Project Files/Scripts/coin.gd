extends Area2D

var speed = 600 #we should make this tween, it would work well

func _process(delta: float) -> void:
	var direction = global_position.direction_to(Vector2(1920,0))
	position += direction * speed * delta


func _on_area_entered(body) -> void:
	if body.is_in_group("coin_collector"):
		Global.player_gain_coin.emit(1)
		queue_free()
