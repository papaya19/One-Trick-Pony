extends Area2D

var speed = 600
var bullet_type: String

func _ready() -> void:
	$".".add_to_group(bullet_type)
	if $".".is_in_group("player_bullet"):
		$ColorRect.color = Color.GREEN
	if $".".is_in_group("enemy_bullet"):
		$ColorRect.color = Color.RED

func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(body) -> void:
	if body.is_in_group("enemy") and not Global.bullets_pierce and not $".".is_in_group("enemy_bullet"):
		queue_free()
	if body.is_in_group("player") and not $".".is_in_group("player_bullet"):
		queue_free()
		Global.player_take_damage.emit(1)
