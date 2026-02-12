extends StaticBody2D


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	Global.player_take_damage.connect(take_damage)
	
func take_damage():
	Global.player_health =- 1
