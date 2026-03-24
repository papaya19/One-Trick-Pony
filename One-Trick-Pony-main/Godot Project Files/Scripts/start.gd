extends Control
@onready var shotgun: TextureButton = $"HBoxContainer/Control/Shotgun"
@onready var assault_rifle: TextureButton = $"HBoxContainer/Control2/Assault Rifle"
@onready var sniper: TextureButton = $"HBoxContainer/Control3/Sniper"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("GOD"):
		Global.selected_weapon = "GOD"
		start_game()

func _on_shotgun_pressed() -> void:
	Global.selected_weapon = "Shotgun"
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(shotgun, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	start_game()

func _on_shotgun_mouse_entered() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(shotgun, "scale", Vector2(1.25,1.25), 0.1).from_current()

func _on_shotgun_mouse_exited() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(shotgun, "scale", Vector2(1,1), 0.1).from_current()

func _on_assault_rifle_pressed() -> void:
	Global.selected_weapon = "Assault Rifle"
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(assault_rifle, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	start_game()

func _on_assault_rifle_mouse_entered() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(assault_rifle, "scale", Vector2(1.25,1.25), 0.1).from_current()

func _on_assault_rifle_mouse_exited() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(assault_rifle, "scale", Vector2(1,1), 0.1).from_current()

func _on_sniper_pressed() -> void:
	Global.selected_weapon = "Sniper"
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(sniper, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	start_game()

func _on_sniper_mouse_entered() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(sniper, "scale", Vector2(1.25,1.25), 0.1).from_current()


func _on_sniper_mouse_exited() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(sniper, "scale", Vector2(1,1), 0.1).from_current()

func start_game():
	get_node("/root/Global/GUI/HUD").process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/Technical/level.tscn")
