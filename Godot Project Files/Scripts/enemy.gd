extends Node2D

const enemy_speed: int = 100
const energy: PackedScene = preload("res://Scenes/energy.tscn")
var enemy_health: int = 100

func _process(delta: float) -> void:
	var direction = global_position.direction_to(get_node("/root/Level/Player").global_position)
	position += direction * enemy_speed * delta
	look_at(get_node("/root/Level/Player").global_position)

func _on_area_2d_area_entered(body) -> void:
	if body.is_in_group("bullet"):
		enemy_take_damage(Global.bullet_damage)
	if body.is_in_group("player"):
		Global.player_take_damage.emit(1)
		queue_free()

func enemy_take_damage(damage_amount):
	enemy_health -= damage_amount
	if enemy_health <= 0:
		queue_free()
		spawn_energy()

func spawn_energy():
	var energy_instance = energy.instantiate()
	energy_instance.global_position = global_position
	get_tree().root.add_child.call_deferred(energy_instance)# this does mean that coin instances 
