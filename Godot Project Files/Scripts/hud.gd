extends Control

@onready var label_ammo = $"Ammo"
@onready var health_bar = $"Health Bar"
@onready var label_coins = $"Coins"

func _process(_delta: float) -> void:
	if Global.reloading:
		label_ammo.text = "Reloading"
	else:
		label_ammo.text = "Ammo: " + str(Global.bullet_count) + "/" + str(Global.magazine_size)

	health_bar.frame = Global.player_health

	label_coins.text = "Energy: " + str(Global.energy_count)
