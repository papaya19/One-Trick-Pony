extends StaticBody2D


func _ready() -> void:
	Global.player_take_damage.connect(take_damage)

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
func take_damage(damage):
	Global.player_health -= damage
