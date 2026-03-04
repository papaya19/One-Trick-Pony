extends Node2D

const energy: PackedScene = preload("res://Scenes/Spawning/energy.tscn")
var enemy_speed: int
var enemy_damage: int 
var enemy_health: int
var energy_dropped: int
var can_split: bool
var can_explode: bool
var enemy_type: String

func _ready() -> void:
	$Sprite2D.texture = load(Global.enemy_stats[enemy_type]["texture_file_path"])
	enemy_speed = Global.enemy_stats[enemy_type]["speed"] 
	enemy_damage = Global.enemy_stats[enemy_type]["damage"] 
	energy_dropped = Global.enemy_stats[enemy_type]["energy_dropped"] 
	enemy_health = Global.enemy_stats[enemy_type]["health"] 
	can_split = Global.enemy_stats[enemy_type]["can_split"] 
	can_explode = Global.enemy_stats[enemy_type]["can_explode"] 

func _process(delta: float) -> void:
	var direction = global_position.direction_to(get_node("/root/Level/Player").global_position)
	position += direction * enemy_speed * delta
	look_at(get_node("/root/Level/Player").global_position)

func _on_area_2d_area_entered(body) -> void:
	if body.is_in_group("bullet"):
		enemy_take_damage(Global.bullet_damage)
	if body.is_in_group("player"):
		Global.player_take_damage.emit(round(lerp(1, 2, (float(enemy_health) /  Global.enemy_stats[enemy_type]["health"]))))
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
