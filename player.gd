extends Node2D


func _ready() -> void:
	Global.player_take_damage.connect(take_damage)
	Global.player_gain_energy.connect(gain_energy)
	change_ship(Global.selected_ship)

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Global.player_health <= 0:
		player_died()
		
	
func take_damage(damage):
	if not Global.invincible:
		Global.player_health -= damage
		$CPUParticles2D.amount = damage * 100
		$CPUParticles2D.emitting = true
		Global.shake_screen(50.0, 0.5)

func gain_energy(energy_value):
	Global.energy_count += energy_value

func player_died():
	Global.queue_lose.emit()

func change_ship(ship):
	$Sprite2D.texture = load(Global.ship_stats[ship]["texture_file_path"])
	$CPUParticles2D.texture = load(Global.ship_stats[ship]["death_particles_file_path"])
	Global.magazine_size = Global.ship_stats[ship]["magazine_size"]
	Global.bullet_damage = Global.ship_stats[ship]["bullet_damage"]
	Global.reload_time = Global.ship_stats[ship]["reload_time"]
	Global.shooting_speed = Global.ship_stats[ship]["shooting_speed"]
	Global.spread = Global.ship_stats[ship]["spread"]
	Global.bullets_per_shot = Global.ship_stats[ship]["bullets_per_shot"]
	Global.bullets_pierce = Global.ship_stats[ship]["bullets_pierce"]
