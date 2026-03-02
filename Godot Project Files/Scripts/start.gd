extends Control

func _ready() -> void:
	pass

func _on_shotgun_pressed() -> void:
	Global.selected_weapon = $HBoxContainer/Control/Shotgun.text
	start_game()

func _on_assult_riffle_pressed() -> void:
	Global.selected_weapon = $"HBoxContainer/Control2/Assault Rifle".text
	start_game()

func _on_sniper_pressed() -> void:
	Global.selected_weapon = $HBoxContainer/Control3/Sniper.text
	start_game()
	
func start_game():
	get_node("/root/Global/GUI/HUD").process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/Technical/level.tscn")
