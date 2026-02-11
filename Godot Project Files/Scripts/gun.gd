extends Node2D

const bullet = preload("res://Scenes/bullet.tscn")
var can_shoot = true
var magazine_size = 10
var bullet_count = 10
var reload_time = 2
var shooting_speed = 0.3


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("reload") and not Input.is_action_pressed("shoot") and bullet_count != magazine_size:
		can_shoot = false
		await get_tree().create_timer(reload_time).timeout
		bullet_count = magazine_size
		can_shoot = true
	
	if Input.is_action_pressed("shoot") and can_shoot:
		can_shoot = false
		shoot()
		bullet_count = bullet_count - 1
		await get_tree().create_timer(shooting_speed).timeout
		if bullet_count != 0:
			can_shoot = true


func shoot():
	var bullet_instance = bullet.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.rotation = rotation
	
