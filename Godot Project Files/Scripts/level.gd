extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.position = Global.screen_size / 2
	$Gun.position = Global.screen_size / 2
	$"Energy Collector".position = Vector2(Global.screen_size.x, 0)
	$CanvasLayer/BlackHole.position.x = randi_range(300, Global.screen_size.x - 300)
	$CanvasLayer/BlackHole.position.y = randi_range(300, Global.screen_size.y - 300)
