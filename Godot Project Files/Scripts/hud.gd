extends Control

@onready var label_ammo = $Ammo
@onready var label_health = $Health
@onready var label_coins = $Coins

func _process(delta: float) -> void:
	if Global.reloading:
		label_ammo.text = "Reloading"
	else:
		label_ammo.text = "Ammo: " + str(Global.bullet_count) + "/" + str(Global.magazine_size)

	if Global.player_health <= 0:
		label_health.text = "Dead"
	else:
		label_health.text = "Health: " + str(Global.player_health)

	label_coins.text = "Coins: " + str(Global.coin_count)
