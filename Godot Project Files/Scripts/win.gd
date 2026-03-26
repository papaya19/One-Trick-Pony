extends Control


func _ready() -> void:
	Global.queue_win.connect(win)
	self.visible = false
	get_tree().paused = false

func win():
	self.visible = true
	get_tree().paused = true

func _on_button_pressed() -> void:
	self.visible = false
	get_tree().paused = false
