extends Node2D

const enemy: PackedScene  = preload("res://Scenes/Spawning/enemy.tscn")
var enemy_spawn_time: float = 1.2
var enemy_can_spawn: bool = true
@export var margin: float = 100
@onready var screen_size: Vector2 = get_viewport_rect().size
var spawn_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	if true: #temp spawn chnaces chaqnge to true for it to take affect, or false to stop it
		Global.enemy_stats["Basic"]["spawn_chance"] += Global.enemy_stats["Shooter"]["spawn_chance"]
		Global.enemy_stats["Sprinter"]["spawn_chance"] 
		Global.enemy_stats["Shooter"]["spawn_chance"] = 0
		Global.enemy_stats["Exploder"]["spawn_chance"] 
		Global.enemy_stats["Sentinal"]["spawn_chance"] 

func _process(_delta: float) -> void:
	if enemy_can_spawn:
		enemy_can_spawn = false
		await get_tree().create_timer(enemy_spawn_time).timeout
		summon_enemy()
		enemy_can_spawn = true

func summon_enemy():
	get_random_coordinates()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_pos
	enemy_instance.enemy_type = get_random_enemy()
	add_child(enemy_instance)

func get_random_enemy():
	var current_sum = 0
	var random = randi_range(1,100)
	for enemy_name in Global.enemy_stats:
		current_sum += Global.enemy_stats[enemy_name]["spawn_chance"]
		if random <= current_sum:
			return enemy_name


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
