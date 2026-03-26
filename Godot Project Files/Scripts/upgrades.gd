extends Control

@onready var option_1: Control = $"VBoxContainer/Upgrades/Control1/Option_1"
@onready var option_2: Control = $"VBoxContainer/Upgrades/Control2/Option_2"
@onready var option_3: Control = $"VBoxContainer/Upgrades/Control3/Option_3"
@onready var refresh: Control = $"VBoxContainer/Refresh/Control1/Refresh"
@onready var heal: Control = $"VBoxContainer/Refresh/Control2/Heal"
@onready var exit: Control = $"VBoxContainer/Refresh/Control3/Exit"

var option_1_upgrade: String
var option_2_upgrade: String
var option_3_upgrade: String
var option_1_value: int
var option_2_value: int
var option_3_value: int

var refresh_cost = 3
var heal_cost = 5

func _ready() -> void:
	refresh_shop()
	Global.queue_upgrade.connect(start)
	self.visible = false
	get_tree().paused = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit") and get_tree().paused:
		self.visible = false
		get_tree().paused = false

	if option_1_upgrade == "" or option_2_upgrade == "" or option_3_upgrade == "": 
		return


	if Global.energy_count >= Global.upgrade_stats[option_1_upgrade]["values"][option_1_value]["cost"]:
		option_1.disabled = false
	else:
		option_1.disabled = true
	
	if Global.energy_count >= Global.upgrade_stats[option_2_upgrade]["values"][option_2_value]["cost"]:
		option_2.disabled = false
	else:
		option_2.disabled = true
	
	if Global.energy_count >= Global.upgrade_stats[option_3_upgrade]["values"][option_3_value]["cost"]:
		option_3.disabled = false
	else:
		option_3.disabled = true
	
	if Global.energy_count >= refresh_cost:
		refresh.disabled = false
	else:
		refresh.disabled = true

	if Global.player_health < 8 and Global.energy_count >= heal_cost:
		heal.disabled = false
	else:
		heal.disabled = true

func refresh_shop():
	option_1_upgrade = Global.upgrade_stats.keys().pick_random()
	option_2_upgrade = Global.upgrade_stats.keys().pick_random()
	option_3_upgrade = Global.upgrade_stats.keys().pick_random()
	option_1_value = get_random_value(option_1_upgrade)
	option_2_value = get_random_value(option_2_upgrade)
	option_3_value = get_random_value(option_3_upgrade)
	#$VBoxContainer/Upgrades/Control1/Option_1.text = Global.upgrade_stats[option_1_upgrade]["description"] + str(option_1_value) + "%"
	#$"VBoxContainer/Upgrades/Control2/Option_2".text = Global.upgrade_stats[option_2_upgrade]["description"] + str(option_2_value) + "%"
	#$"VBoxContainer/Upgrades/Control3/Option_3".text = Global.upgrade_stats[option_3_upgrade]["description"] + str(option_3_value) + "%"
	option_1.visible = true
	option_2.visible = true
	option_3.visible = true

func start():
	get_node("/root/Level/Energy Collector").scale = Vector2(52,40)
	await get_tree().create_timer(0.2).timeout
	get_node("/root/Level/Energy Collector").scale = Vector2(1,1)
	self.visible = true
	get_tree().paused = true

func upgrade(selected_upgrade, selected_upgrade_value):
	if Global.upgrade_stats[selected_upgrade]["decrease"]:
		Global.set(selected_upgrade, Global.get(selected_upgrade) - Global.get(selected_upgrade) * selected_upgrade_value * 0.01)
	else:
		Global.set(selected_upgrade, Global.get(selected_upgrade) + Global.get(selected_upgrade) * selected_upgrade_value * 0.01)
	
	Global.energy_count -=  Global.upgrade_stats[selected_upgrade]["values"][selected_upgrade_value]["cost"]

func get_random_value(option):
	var current_sum = 0
	var random = randi_range(1,100)
	for value_amount in Global.upgrade_stats[option]["values"]:
		current_sum += Global.upgrade_stats[option]["values"][value_amount]["chance"]
		if random <= current_sum:
			print(option)
			print(value_amount)
			return value_amount

func _on_option_1_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(option_1, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	option_1.visible = false
	upgrade(option_1_upgrade, option_1_value)
func _on_option_1_mouse_entered() -> void:
	if option_1.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(option_1, "scale", Vector2(1.25,1.25), 0.1).from_current()
func _on_option_1_mouse_exited() -> void:
	if option_1.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(option_1, "scale", Vector2(1,1), 0.1).from_current()

func _on_option_2_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(option_2, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	option_2.visible = false
	upgrade(option_2_upgrade, option_2_value)
func _on_option_2_mouse_entered() -> void:
	if option_2.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(option_2, "scale", Vector2(1.25,1.25), 0.1).from_current()
func _on_option_2_mouse_exited() -> void:
	if option_2.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(option_2, "scale", Vector2(1,1), 0.1).from_current()

func _on_option_3_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(option_3, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	option_3.visible = false
	upgrade(option_3_upgrade, option_3_value)
func _on_option_3_mouse_entered() -> void:
	if option_3.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(option_3, "scale", Vector2(1.25,1.25), 0.1).from_current()
func _on_option_3_mouse_exited() -> void:
	if option_3.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(option_3, "scale", Vector2(1,1), 0.1).from_current()

func _on_refresh_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(refresh, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	refresh.visible = false
	refresh_shop()
	Global.energy_count -= refresh_cost
	refresh.visible = true
	var tween2 = create_tween().set_trans(Tween.TRANS_SPRING)
	tween2.tween_property(heal, "scale", Vector2(1,1), 0.2)
func _on_refresh_mouse_entered() -> void:
	if refresh.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SPRING)
		tween.tween_property(refresh, "scale", Vector2(1.25,1.25), 0.1).from_current()
func _on_refresh_mouse_exited() -> void:
	if refresh.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SPRING)
		tween.tween_property(refresh, "scale", Vector2(1,1), 0.1).from_current()

func _on_heal_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(heal, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	heal.visible = false
	Global.player_health += 1
	Global.energy_count -= heal_cost
	heal.visible = true
	var tween2 = create_tween().set_trans(Tween.TRANS_SPRING)
	tween2.tween_property(heal, "scale", Vector2(1,1), 0.2)
func _on_heal_mouse_entered() -> void:
	if heal.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SPRING)
		tween.tween_property(heal, "scale", Vector2(1.25,1.25), 0.1).from_current()
func _on_heal_mouse_exited() -> void:
	if heal.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SPRING)
		tween.tween_property(heal, "scale", Vector2(1,1), 0.1).from_current()

func _on_exit_pressed() -> void:
	var tween = create_tween().set_trans(Tween.TRANS_SPRING)
	tween.tween_property(exit, "scale", Vector2(0,0), 0.1).from_current()
	await tween.finished
	exit.visible = false
	self.visible = false
	get_tree().paused = false
	Global.bullet_count = Global.magazine_size
	exit.visible = true
func _on_exit_mouse_entered() -> void:
	if exit.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SPRING)
		tween.tween_property(exit, "scale", Vector2(1.25,1.25), 0.1).from_current()
func _on_exit_mouse_exited() -> void:
	if exit.disabled == false:
		var tween = create_tween().set_trans(Tween.TRANS_SPRING)
		tween.tween_property(exit, "scale", Vector2(1,1), 0.1).from_current()
