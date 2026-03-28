extends Control


func _ready() -> void:
	Global.queue_lose.connect(lose)
	self.visible = false
	get_tree().paused = false

func lose():
	self.visible = true
	get_tree().paused = true

func _on_button_pressed() -> void:
	self.visible = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Technical/start.tscn")
	Global.energy_count = 0
	Global.reloading = false
	Global.bullet_count = 0
	Global.player_health = 8
	Global.current_wave = 1
	Global.refresh_cost = 2
	Global.heal_cost = 5
	Global.upgrade_multiplier = 1

func _on_button_2_pressed() -> void:
	get_tree().quit()
