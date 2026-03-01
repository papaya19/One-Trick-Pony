extends Control


func _on_shotgun_pressed() -> void:
	start_game($HBoxContainer/Control/Shotgun.text)


func _on_assult_riffle_pressed() -> void:
	start_game($"HBoxContainer/Control2/Assault Rifle".text)

func _on_sniper_pressed() -> void:
	start_game($HBoxContainer/Control3/Sniper.text)

func start_game(weapon):
	print("selected ", weapon)
	get_node("/root/Global/GUI/HUD").process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
