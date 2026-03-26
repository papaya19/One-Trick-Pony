extends AudioStreamPlayer

var playlist: Array = [
	preload("res://Assets/Sounds/Music/2026-03-17T03_57_05.313Z.wav"),
	preload("res://Assets/Sounds/Music/sagar sandhra - New Project 2026-02-05 16_27.mp3"),
	preload("res://Assets/Sounds/Music/sagar sandhra - New Project 2026-02-09 21_01.mp3"),
	preload("res://Assets/Sounds/Music/thestrudelsong.wav")
]
func _ready():
	pass
	play_random_song()

func play_random_song():
	stream = playlist.pick_random()
	play()

# Optional: To play a new one automatically when the current song ends
func _on_finished():
	play_random_song()
