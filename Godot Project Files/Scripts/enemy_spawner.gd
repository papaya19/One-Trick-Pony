extends Node2D

const enemy: PackedScene  = preload("res://Scenes/Spawning/enemy.tscn")
var enemy_spawn_time: float = 1.2
var enemy_can_spawn: bool = true
@export var margin: float = 100
@onready var screen_size: Vector2 = get_viewport_rect().size
var spawn_pos = Vector2.ZERO
var enemies: Array = ["Basic", "Sprinter", "Shooter", "Exploding", "Sentinal"]
var spawning_enemy: String


func _process(_delta: float) -> void:
	if enemy_can_spawn:
		enemy_can_spawn = false
		await get_tree().create_timer(enemy_spawn_time).timeout
		on_wave_start()
		summon_enemy()
		enemy_can_spawn = true

func on_wave_start():
	pass

func summon_enemy():
	spawning_enemy = enemies[randi_range(0,4)]
	get_random_coordinates()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_pos
	enemy_instance.enemy_type = spawning_enemy
	add_child(enemy_instance)
	


func get_random_coordinates():
	var side = randi() % 4
	
	match side:
		0: # Top
			spawn_pos.x = randf_range(margin, screen_size.x - margin)
			spawn_pos.y = margin
		1: # Bottom
			spawn_pos.x = randf_range(margin, screen_size.x - margin)
			spawn_pos.y = screen_size.y - margin
		2: # Left
			spawn_pos.x = margin
			spawn_pos.y = randf_range(margin, screen_size.y - margin)
		3: # Right
			spawn_pos.x = screen_size.x - margin
			spawn_pos.y = randf_range(margin, screen_size.y - margin)
