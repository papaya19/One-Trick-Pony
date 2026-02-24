extends Node

signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
var player_health: int = 8
var magazine_size: int = 10
var bullet_count: int = 10
@export var energy_count: int = 0
@export var invincible: bool = true
var reloading: bool = false

func _ready() -> void:
	$"GUI/HUD".process_mode = Node.PROCESS_MODE_DISABLED
