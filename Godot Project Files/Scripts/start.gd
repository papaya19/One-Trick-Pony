extends Control


func _on_shotgun_pressed() -> void:
	get_node("/root/Global/GUI/HUD").process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	print("shotyy")


func _on_assult_riffle_pressed() -> void:
	get_node("/root/Global/GUI/HUD").process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	print("arrrrr")


func _on_sniper_pressed() -> void:
	get_node("/root/Global/GUI/HUD").process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
	print("360 no scope")
