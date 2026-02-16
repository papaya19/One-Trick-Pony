extends Node2D

var speed = 100
const coin = preload("res://Scenes/coin.tscn")

func _process(delta: float) -> void:
	var direction = global_position.direction_to(Vector2(960,540))
	position += direction * speed * delta


func _on_area_2d_area_entered(body) -> void:
	var direction = global_position.direction_to(Vector2(960,540))
	if body.is_in_group("bullet"):
		spawn_coin()
		queue_free()
	if body.is_in_group("player"):
		Global.player_take_damage.emit(1)
		queue_free()

func spawn_coin():
	var coin_instance = coin.instantiate()
	coin_instance.global_position = global_position
	get_parent().add_child.call_deferred(coin_instance)# this does mean that coin instances 
