
extends Camera2D

func _ready():
	Global.request_shake.connect(_on_shake_requested)
	enabled = true 
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	var screen_size = get_viewport_rect().size
	global_position = screen_size / 2
	Global.request_shake.connect(_on_shake_requested)

func _process(_delta):
	if shake_intensity > 0:
		offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake_intensity
	pass

var shake_intensity = 0.0

func _on_shake_requested(intensity, duration):
	shake_intensity = intensity
	await get_tree().create_timer(duration).timeout
	shake_intensity = 0.0
	offset = Vector2.ZERO
