extends Node

signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
var player_health: int = 8
var magazine_size: int = 30
var bullet_count: int = 30
@export var energy_count: int = 0
@export var invincible: bool = true
var reloading: bool = false
var bullet_damage: int = 40

func _ready() -> void:
	$"GUI/HUD".process_mode = Node.PROCESS_MODE_DISABLED
