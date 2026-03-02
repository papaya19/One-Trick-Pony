extends Node

var ship_stats = {
	"Shotgun": {"texture_file_path": "res://Assets/Ships/Shotgun.png", 
	"magazine_size": 6, "bullet_damage": 30, "reload_time": 1.8, "shooting_speed": 0.8, "spread": 0.3, "bullets_per_shot": 5, "bullets_pierce": false},
	
	"Assault Rifle": {"texture_file_path": "res://Assets/Ships/Assault Rifle.png", 
	"magazine_size": 20, "bullet_damage": 60, "reload_time": 1.3, "shooting_speed": 0.3, "spread": 0, "bullets_per_shot": 1, "bullets_pierce": false},
	
	"Sniper": {"texture_file_path": "res://Assets/Ships/Sniper.png", 
	"magazine_size": 3, "bullet_damage": 180, "reload_time": 3.25, "shooting_speed": 1.25, "spread": 0, "bullets_per_shot": 1, "bullets_pierce": true}
	
}

signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
@export var energy_count: int = 0
@export var invincible: bool = false
@export var selected_weapon: String
var reloading: bool = false
var bullet_count: int = 0
var player_health: int = 8
var magazine_size: int
var bullet_damage: int
var reload_time: float
var shooting_speed: float
var spread: float
var bullets_per_shot: int
var bullets_pierce: bool


func _ready() -> void:
	$"GUI/HUD".process_mode = Node.PROCESS_MODE_DISABLED
