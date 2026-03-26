extends Control

@onready var label_ammo = $"Indicators/Bullet/Ammo"
@onready var health_bar = $"Indicators/Health/Health Bar"
@onready var label_energy = $"Indicators/Orb/Energy"
@onready var label_wave = $"Indicators/Enemy/Wave"

func _process(_delta: float) -> void:
	if Global.reloading:
		label_ammo.text = "Reloading"
	else:
		label_ammo.text = "Ammo: " + str(Global.bullet_count) + "/" + str(Global.magazine_size)

	health_bar.frame = Global.player_health

	label_energy.text = "Energy: " + str(Global.energy_count)

	label_wave.text = "Wave: " + str(Global.current_wave)
