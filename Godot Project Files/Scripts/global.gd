extends Node

signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
@export var energy_count: int = 0
@export var invincible: bool = false
var reloading: bool = false
var bullet_count: int = 0

var player_health: int = 8

var magazine_size: int = 20
var bullet_damage: int = 60
var reload_time: float = 1.2
var shooting_speed: float = 0.3
var spread: float = 0
var bullets_per_shot = 1


func _ready() -> void:
	$"GUI/HUD".process_mode = Node.PROCESS_MODE_DISABLED
