extends Node

var ship_stats: Dictionary = {
	"Shotgun": {"texture_file_path": "res://Assets/Ships/Shotgun.png", 
	"magazine_size": 6, "bullet_damage": 40, "reload_time": 1.8, "shooting_speed": 0.8, "spread": 0.2, "bullets_per_shot": 8, "bullets_pierce": false},
	
	"Assault Rifle": {"texture_file_path": "res://Assets/Ships/Assault_Rifle.png", 
	"magazine_size": 20, "bullet_damage": 60, "reload_time": 1.3, "shooting_speed": 0.3, "spread": 0, "bullets_per_shot": 1, "bullets_pierce": false},
	
	"Sniper": {"texture_file_path": "res://Assets/Ships/Sniper.png", 
	"magazine_size": 3, "bullet_damage": 180, "reload_time": 2.25, "shooting_speed": 1.25, "spread": 0, "bullets_per_shot": 1, "bullets_pierce": true},
	
	"GOD": {"texture_file_path": "res://Assets/Background/Black_Hole.png", 
	"magazine_size": -1, "bullet_damage": 1000, "reload_time": 0, "shooting_speed": 0, "spread": 360, "bullets_per_shot": 100, "bullets_pierce": true}
}
var enemy_stats: Dictionary = {
	"Basic": {"texture_file_path": "res://Assets/Enemies/Basic.png", "spawn_chance": 60,
	"speed": 100, "damage": 1, "energy_dropped_value": 1, "health": 100, "scale": Vector2(1,1), "can_shoot": false, "can_explode": false},
	
	"Sprinter": {"texture_file_path": "res://Assets/Enemies/Sprinter.png", "spawn_chance": 20,
	"speed": 300, "damage": 1, "energy_dropped_value": 1, "health": 60, "scale": Vector2(1,1), "can_shoot": false, "can_explode": false},
	
	"Shooter": {"texture_file_path": "res://Assets/Enemies/Shooter.png", "spawn_chance": 8,
	"speed": 100, "damage": 1, "energy_dropped_value": 1, "health": 100, "scale": Vector2(1,1), "can_shoot": true, "can_explode": false},
	
	"Exploder": {"texture_file_path": "res://Assets/Enemies/Exploder.png", "spawn_chance": 8,
	"speed": 100, "damage": 1, "energy_dropped_value": 1, "health": 100, "scale": Vector2(1,1), "can_shoot": false, "can_explode": true},
	
	"Sentinal": {"texture_file_path": "res://Assets/Enemies/Sentinal.png","spawn_chance": 4,
	"speed": 50, "damage": 2, "energy_dropped_value": 3, "health": 500, "scale": Vector2(2,2), "can_shoot": false, "can_explode": false},
}


signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
signal queue_upgrade()
@export var energy_count: int = 0
@export var invincible: bool = false
@export var selected_weapon: String
var reloading: bool = false
var bullet_count: int = 0
var player_health: int = 8
var current_wave = 1
var enemy_spawn_time: float = 2.8

var magazine_size: int
var bullet_damage: int
var reload_time: float
var shooting_speed: float
var spread: float
var bullets_per_shot: int
var bullets_pierce: bool


func _ready() -> void:
	$"GUI/HUD".process_mode = Node.PROCESS_MODE_DISABLED
