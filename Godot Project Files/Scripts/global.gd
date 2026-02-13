extends Node

signal player_take_damage(damage_amount: int)
@export var player_health = 8
@export var magazine_size = 10
@export var coin_count = 0
var bullet_count = 10
var reloading = false
