extends Node2D


func _ready() -> void:
	Global.player_take_damage.connect(take_damage)
	Global.player_gain_energy.connect(gain_energy)

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Global.player_health <= 0:
		player_died()
	
func take_damage(damage):
	Global.player_health -= damage

func gain_energy(energy_value):
	Global.energy_count += energy_value

func player_died():
	get_tree().quit()
