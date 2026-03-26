extends Node2D

const bullet: PackedScene  = preload("res://Scenes/Spawning/bullet.tscn")


func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if (Input.is_action_just_pressed("reload") or Global.bullet_count == 0) and not Input.is_action_pressed("shoot") and Global.bullet_count != Global.magazine_size and not Global.reloading:
		Global.reloading = true
		Global.can_shoot = false
		await get_tree().create_timer(Global.reload_time).timeout
		Global.bullet_count = Global.magazine_size
		Global.can_shoot = true
		Global.reloading = false

	if Input.is_action_pressed("shoot") and Global.can_shoot:
		Global.can_shoot = false
		for i in range(Global.bullets_per_shot):
			shoot(((Global.spread / Global.bullets_per_shot) * i) - Global.spread / 2)
		Global.bullet_count = Global.bullet_count - 1
		await get_tree().create_timer(Global.shooting_speed).timeout
		if Global.bullet_count != 0:
			Global.can_shoot = true

func shoot(offset):
	var bullet_instance = bullet.instantiate()
	bullet_instance.bullet_type = "player_bullet"
	bullet_instance.global_position = global_position
	bullet_instance.rotation = rotation + offset
	get_tree().root.add_child(bullet_instance)
