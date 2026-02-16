extends Node2D


func _ready() -> void:
	Global.player_take_damage.connect(take_damage)
	Global.player_gain_coin.connect(get_coin)

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Global.player_health <= 0:
		player_died()
	
func take_damage(damage):
	Global.player_health -= damage

func get_coin(coin_value):
	Global.coin_count += coin_value

func player_died():
	get_tree().quit()
