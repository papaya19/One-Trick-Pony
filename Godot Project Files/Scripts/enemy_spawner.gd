extends Node2D

const enemy: PackedScene  = preload("res://Scenes/Spawning/enemy.tscn")
var enemy_can_spawn: bool = true
@export var margin: float = 100
var spawn_pos: Vector2 = Vector2.ZERO
var enemies_spawned: int
var enemies_to_spawn: int = 10
var wave_multiplier = 0.5
var wave_active: bool

func _ready() -> void:
	Global.wave_start.connect(wave_start)

func wave_start():
	enemy_can_spawn = true
	Global.can_shoot = true

func _process(_delta: float) -> void:
	if enemy_can_spawn:
		enemy_can_spawn = false
		await get_tree().create_timer(Global.enemy_spawn_time).timeout
		summon_enemy()
		enemy_can_spawn = true
		enemies_spawned += 1
		wave_active = true
		

	if enemies_spawned >= enemies_to_spawn:
		enemy_can_spawn = false

	if get_node("/root/Level/Enemy Spawner").get_child_count() == 0 and wave_active and not enemy_can_spawn:
		wave_finished()


func wave_finished():
	wave_active = false
	Global.can_shoot = false
	if Global.current_wave == 10:
		Global.queue_win.emit()
	Global.queue_upgrade.emit()
	Global.current_wave += 1
	enemies_to_spawn += Global.current_wave * wave_multiplier
	Global.enemy_spawn_time -= Global.current_wave * pow(wave_multiplier, 4)
	enemies_spawned = 0

func summon_enemy():
	get_random_coordinates()
	var enemy_type = get_random_enemy()
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = spawn_pos
	enemy_instance.enemy_type = enemy_type
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
			spawn_pos.x = randf_range(margin, Global.screen_size.x - margin)
			spawn_pos.y = margin
		1: # Bottom
			spawn_pos.x = randf_range(margin, Global.screen_size.x - margin)
			spawn_pos.y = Global.screen_size.y - margin
		2: # Left
			spawn_pos.x = margin
			spawn_pos.y = randf_range(margin, Global.screen_size.y - margin)
		3: # Right
			spawn_pos.x = Global.screen_size.x - margin
			spawn_pos.y = randf_range(margin, Global.screen_size.y - margin)
