extends Node2D

const enemy = preload("res://Scenes/enemy.tscn")
var enemy_spawn_time = 1
var enemy_can_spawn = true
@export var margin: float = 100
@onready var screen_size = get_viewport_rect().size
var spawn_pos = Vector2.ZERO

func _ready() -> void:
	if enemy_can_spawn:
		enemy_can_spawn = false
		await get_tree().create_timer(enemy_spawn_time).timeout
		summon_enemy()
		enemy_can_spawn = true

func _process(delta: float) -> void:
	if enemy_can_spawn:
		enemy_can_spawn = false
		await get_tree().create_timer(enemy_spawn_time).timeout
		summon_enemy()
		enemy_can_spawn = true


func summon_enemy():
	get_random_coordinates()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_pos
	add_child(enemy_instance)
	


func get_random_coordinates():
	var screen_size = get_viewport_rect().size
	
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
