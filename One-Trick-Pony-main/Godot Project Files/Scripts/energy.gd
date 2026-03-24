extends Area2D

var speed: int = 2.5
var energy_value: int

func _ready() -> void:
	look_at(get_node("/root/Level/Energy Collector").global_position)
	var tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", get_node("/root/Level/Energy Collector").position, speed)


func _on_area_entered(body) -> void:
	if body.is_in_group("energy_collector"):
		Global.player_gain_energy.emit(energy_value)
		queue_free()
