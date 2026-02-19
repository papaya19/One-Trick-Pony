extends Node

signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
@export var player_health: int = 10
@export var magazine_size: int = 10
@export var energy_count: int = 0
@export var bullet_count: int = 10
var reloading = false

func _ready() -> void:
	$"GUI/HUD".process_mode = Node.PROCESS_MODE_DISABLED
