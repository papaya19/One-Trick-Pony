extends Node2D


func _ready() -> void:
	Global.player_take_damage.connect(take_damage)
	Global.player_gain_energy.connect(gain_energy)
	change_weapon(Global.selected_weapon)

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Global.player_health <= 0:
		player_died()
	
func take_damage(damage):
	if not Global.invincible:
		Global.player_health -= damage

func gain_energy(energy_value):
	Global.energy_count += energy_value

func player_died():
	get_tree().quit()

func change_weapon(weapon):
	$Sprite2D.texture = load(Global.ship_stats[weapon]["texture_file_path"])
	Global.magazine_size = Global.ship_stats[weapon]["magazine_size"]
	Global.bullet_damage = Global.ship_stats[weapon]["bullet_damage"]
	Global.reload_time = Global.ship_stats[weapon]["reload_time"]
	Global.shooting_speed = Global.ship_stats[weapon]["shooting_speed"]
	Global.spread = Global.ship_stats[weapon]["spread"]
	Global.bullets_per_shot = Global.ship_stats[weapon]["bullets_per_shot"]
