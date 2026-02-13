extends Area2D

var speed = 600
var direction = Vector2.RIGHT

func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_area_entered(body) -> void:
	if body.is_in_group("enemy"):
		queue_free()
