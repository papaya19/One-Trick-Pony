extends Node2D

var enemy_speed: int = 100
const energy: PackedScene = preload("res://Scenes/energy.tscn")

func _process(delta: float) -> void:
	var direction = global_position.direction_to(Vector2(960,540))
	position += direction * enemy_speed * delta
	look_at(get_node("/root/Level/Player").global_position)


func _on_area_2d_area_entered(body) -> void:
	if body.is_in_group("bullet"):
		spawn_coin()
		queue_free()
	if body.is_in_group("player"):
		Global.player_take_damage.emit(1)
		queue_free()

func spawn_coin():
	var energy_instance = energy.instantiate()
	energy_instance.global_position = global_position
	get_tree().root.add_child.call_deferred(energy_instance)# this does mean that coin instances 
