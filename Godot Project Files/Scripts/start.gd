extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("GOD"):
		Global.selected_weapon = "GOD"
		start_game()

func _on_shotgun_pressed() -> void:
	Global.selected_weapon = $HBoxContainer/Control/Shotgun/Label.text
	start_game()

func _on_shotgun_mouse_entered() -> void:
	$HBoxContainer/Control/Shotgun.scale = Vector2(1.2,1.2)

func _on_shotgun_mouse_exited() -> void:
	$HBoxContainer/Control/Shotgun.scale = Vector2(1,1)

func _on_assult_riffle_pressed() -> void:
	Global.selected_weapon = $"HBoxContainer/Control2/Assault Rifle/Label".text
	start_game()

func _on_assault_rifle_mouse_entered() -> void:
	$"HBoxContainer/Control2/Assault Rifle".scale = Vector2(1.2,1.2)

func _on_assault_rifle_mouse_exited() -> void:
	$"HBoxContainer/Control2/Assault Rifle".scale = Vector2(1,1)

func _on_sniper_pressed() -> void:
	Global.selected_weapon = $HBoxContainer/Control3/Sniper/Label.text
	start_game()

func _on_sniper_mouse_entered() -> void:
	$HBoxContainer/Control3/Sniper.scale = Vector2(1.2,1.2)


func _on_sniper_mouse_exited() -> void:
	$HBoxContainer/Control3/Sniper.scale = Vector2(1,1)

func start_game():
	get_node("/root/Global/GUI/HUD").process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/Technical/level.tscn")
