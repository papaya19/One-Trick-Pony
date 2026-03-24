extends Node2D

const energy: PackedScene = preload("res://Scenes/Spawning/energy.tscn")
const explosion: PackedScene  = preload("res://Scenes/Spawning/explosion.tscn")
const bullet: PackedScene  = preload("res://Scenes/Spawning/bullet.tscn")
var enemy_speed: int
var enemy_damage: int 
var enemy_health: int
var energy_dropped_value: int
var can_shoot: bool
var can_explode: bool
var enemy_type: String

func _ready() -> void:
	look_at(get_node("/root/Level/Player").global_position)
	$Sprite2D.texture = load(Global.enemy_stats[enemy_type]["texture_file_path"])
	$CPUParticles2D.texture = load(Global.enemy_stats[enemy_type]["death_particles_file_path"])
	$CPUParticles2D.amount = Global.enemy_stats[enemy_type]["health"] 
	$".".scale = Global.enemy_stats[enemy_type]["scale"]
	enemy_speed = Global.enemy_stats[enemy_type]["speed"] 
	enemy_damage = Global.enemy_stats[enemy_type]["damage"] 
	energy_dropped_value = Global.enemy_stats[enemy_type]["energy_dropped_value"] 
	enemy_health = Global.enemy_stats[enemy_type]["health"]  
	can_shoot = Global.enemy_stats[enemy_type]["can_shoot"] 
	can_explode = Global.enemy_stats[enemy_type]["can_explode"] 

func _process(delta: float) -> void:
	var direction = global_position.direction_to(get_node("/root/Level/Player").global_position)
	position += direction * enemy_speed * delta
	if can_shoot and global_position.distance_to(get_node("/root/Level/Player").global_position) < 300:
		can_shoot = false
		enemy_speed = 0
		shoot()
		await get_tree().create_timer(2).timeout
		can_shoot = true

func _on_area_2d_area_entered(body) -> void:
	if body.is_in_group("player_bullet"):
		enemy_take_damage(Global.bullet_damage)
	if body.is_in_group("player"):
		Global.player_take_damage.emit(round(lerp(1, 2, (float(enemy_health) /  Global.enemy_stats[enemy_type]["health"]))))
		queue_free()
	if body.is_in_group("explosion"):
		enemy_take_damage(100)

func enemy_take_damage(damage_amount):
	enemy_health -= damage_amount
	if enemy_health <= 0:
		if can_explode:
			explode()
		$CPUParticles2D.emitting = true
		set_physics_process(false)
		can_shoot = false
		$Sprite2D.hide()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		spawn_energy()
		await get_tree().create_timer($CPUParticles2D.lifetime).timeout
		queue_free()

func spawn_energy():
	var energy_instance = energy.instantiate()
	energy_instance.global_position = global_position
	energy_instance.energy_value = energy_dropped_value
	get_tree().root.add_child.call_deferred(energy_instance)# this does mean that coin instances 

func explode():
	var explosion_instance = explosion.instantiate()
	get_tree().root.add_child.call_deferred(explosion_instance)
	explosion_instance.global_position = global_position

func shoot():
	var bullet_instance = bullet.instantiate()
	bullet_instance.bullet_type = "enemy_bullet"
	bullet_instance.global_position = global_position
	bullet_instance.rotation = global_rotation
	get_tree().root.add_child(bullet_instance)
