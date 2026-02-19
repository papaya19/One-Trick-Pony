extends Area2D

var speed = 600 #we should make this tween, it would work well

func _process(delta: float) -> void:
	var direction = global_position.direction_to(get_node("/root/Level/Energy Collector").global_position)
	position += direction * speed * delta
	look_at(get_node("/root/Level/Energy Collector").global_position)


func _on_area_entered(body) -> void:
	if body.is_in_group("energy_collector"):
		Global.player_gain_energy.emit(1)
		queue_free()
