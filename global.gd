extends Node


signal request_shake(intensity, duration)

func shake_screen(intensity = 5.0, duration = 0.2):
	request_shake.emit(intensity, duration)

var screen_size: Vector2: 
	get:
		return get_viewport().get_visible_rect().size

const ship_stats: Dictionary = {
	"Shotgun": {
		"texture_file_path": "res://Assets/Ships/Shotgun.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Ships/Shotgun_Death.png",
		"magazine_size": 6, 
		"bullet_damage": 10, 
		"reload_time": 1.8, 
		"shooting_speed": 1, 
		"spread": 0.2, 
		"bullets_per_shot": 8, 
		"bullets_pierce": false
	},
	
	"Assault Rifle": {
		"texture_file_path": "res://Assets/Ships/Assault_Rifle.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Ships/Assault_Rifle_Death.png",
		"magazine_size": 20, 
		"bullet_damage": 60, 
		"reload_time": 1.3, 
		"shooting_speed": 0.5, 
		"spread": 0,
		"bullets_per_shot": 1, 
		"bullets_pierce": false
	},
	
	"Sniper": {
		"texture_file_path": "res://Assets/Ships/Sniper.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Ships/Sniper_Death.png",
		"magazine_size": 5, 
		"bullet_damage": 150, 
		"reload_time": 2.25, 
		"shooting_speed": 1.25, 
		"spread": 0, 
		"bullets_per_shot": 1, 
		"bullets_pierce": true
	},
	
	"GOD": {
		"texture_file_path": "res://Assets/Background/Black_Hole.png", 
		"death_particles_file_path": "res://Assets/GUI/Crosshair.png",
		"magazine_size": -1, 
		"bullet_damage": 1000, 
		"reload_time": 0, "shooting_speed": 0, 
		"spread": 360, 
		"bullets_per_shot": 100, 
		"bullets_pierce": true
	}
}
const enemy_stats: Dictionary = {
	"Basic": {
		"texture_file_path": "res://Assets/Enemies/Basic.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Enemies/Basic_Death.png", 
		"spawn_chance": 60,
		"speed": 100, 
		"damage": 1, 
		"energy_dropped_value": 1, 
		"health": 100, 
		"scale": Vector2(1,1), 
		"can_shoot": false, 
		"can_explode": false
	},
	
	"Sprinter": {
		"texture_file_path": "res://Assets/Enemies/Sprinter.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Enemies/Sprinter_Death.png", 
		"spawn_chance": 20,
		"speed": 300, 
		"damage": 1, 
		"energy_dropped_value": 1, 
		"health": 60, 
		"scale": Vector2(1,1), 
		"can_shoot": false, 
		"can_explode": false
	},
	
	"Shooter": {
		"texture_file_path": "res://Assets/Enemies/Shooter.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Enemies/Shooter_Death.png", 
		"spawn_chance": 8,
		"speed": 100, 
		"damage": 1, 
		"energy_dropped_value": 1, 
		"health": 100, 
		"scale": Vector2(1,1), 
		"can_shoot": true, 
		"can_explode": false
	},
	
	"Exploder": {
		"texture_file_path": "res://Assets/Enemies/Exploder.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Enemies/Exploder_Death.png", 
		"spawn_chance": 8,
		"speed": 100, 
		"damage": 1, 
		"energy_dropped_value": 1, 
		"health": 100, 
		"scale": Vector2(1,1), 
		"can_shoot": false, 
		"can_explode": true
	},
	
	"Sentinel": {
		"texture_file_path": "res://Assets/Enemies/Sentinel.png", 
		"death_particles_file_path": "res://Assets/Particles/Death/Enemies/Sentinel_Death.png", 
		"spawn_chance": 4,
		"speed": 50, 
		"damage": 2, 
		"energy_dropped_value": 3, 
		"health": 500, 
		"scale": Vector2(2,2), 
		"can_shoot": false, 
		"can_explode": false
	},
}
const upgrade_stats: Dictionary = {
	"bullet_damage": {
		"tittle": "Damage", 
		"description": "Increases damage by ", 
		"decrease": false,
		"values": {
			10: {"chance": 50, "cost": 2}, 
			25: {"chance": 25, "cost": 4}, 
			50: {"chance": 20, "cost": 6}, 
			75: {"chance": 5, "cost": 8}
		}
	}, 

	"shooting_speed": {
		"tittle": "Fire rate", 
		"description": "Increases fire rate by ", 
		"decrease": true,
		"values": {
			5: {"chance": 50, "cost": 2}, 
			10: {"chance": 25, "cost": 4}, 
			15: {"chance": 20, "cost": 6}, 
			20: {"chance": 5, "cost": 8}
		}
	}, 

	"magazine_size": {
		"tittle": "Ammunition Capacity", 
		"description": "Increases ammunition capacity by ", 
		"decrease": false,
		"values": {
			25: {"chance": 50, "cost": 2}, 
			50: {"chance": 25, "cost": 4}, 
			75: {"chance": 20, "cost": 6}, 
			100: {"chance": 5, "cost": 8}
		}
	}, 

	"reload_time": {
		"tittle": "Reload Speed", 
		"description": "Increases reload speed by ", 
		"decrease": true,
		"values": {
			5: {"chance": 50, "cost": 2}, 
			10: {"chance": 25, "cost": 4}, 
			15: {"chance": 20, "cost": 6}, 
			20: {"chance": 5, "cost": 8}
		}
	}, 
	
}

signal player_take_damage(damage_amount: int)
signal player_gain_energy(energy_value: int)
signal queue_upgrade()
signal queue_win()
signal queue_lose()
signal wave_start()
@export var energy_count: int = 0
@export var invincible: bool = false
@export var selected_ship: String
var reloading: bool = false
var bullet_count: int = 0
var player_health: int = 8
var current_wave: int = 1
var enemy_spawn_time: float = 2.8

var magazine_size: int
var bullet_damage: int
var reload_time: float
var shooting_speed: float
var spread: float
var bullets_per_shot: int
var bullets_pierce: bool

var can_shoot: bool = true


func _ready() -> void:
	$"GUI/HUD".process_mode = Node.PROCESS_MODE_DISABLED
