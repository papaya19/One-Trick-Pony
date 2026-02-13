extends CharacterBody2D

var speed = 100


func _process(delta: float) -> void:
	var direction = global_position.direction_to(Vector2(960,540))
	position += direction * speed * delta


func _on_area_2d_area_entered(body) -> void:
	var direction = global_position.direction_to(Vector2(960,540))
	if body.is_in_group("bullet"):
		queue_free()
	if body.is_in_group("player"):
		Global.player_take_damage.emit(1)
		queue_free()
