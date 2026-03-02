extends Node

var ship_stats = {
	"Shotgun": {"texture_file_path": "res://Assets/Shotgun.png", 
	"magazine_size": 6, "bullet_damage": 30, "reload_time": 1.2, "shooting_speed": 1.2, "spread": 0.3, "bullets_per_shot": 5},
	
	"Assault Rifle": {"texture_file_path": "res://Assets/Assault Rifle.png", 
	"magazine_size": 20, "bullet_damage": 60, "reload_time": 1.2, "shooting_speed": 0.3, "spread": 0, "bullets_per_shot": 1},
	
	"Sniper": {"texture_file_path": "res://Assets/Sniper.png", 
	"magazine_size": 3, "bullet_damage": 180, "reload_time": 1.2, "shooting_speed": 2, "spread": 0, "bullets_per_shot": 1}
	
}

signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
@export var energy_count: int = 0
@export var invincible: bool = false
@export var selected_weapon: String
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
