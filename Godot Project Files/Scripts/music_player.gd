extends AudioStreamPlayer

var playlist: Array = [
	preload("res://Assets/Sounds/Music/2026-03-17T03_57_05.313Z.wav"),
	preload("res://Assets/Sounds/Music/sagar sandhra - New Project 2026-02-05 16_27.mp3"),
	preload("res://Assets/Sounds/Music/sagar sandhra - New Project 2026-02-05 16_27.mp3"),
	preload("res://Assets/Sounds/Music/thestrudelsong.wav")
]
func _ready():
	# Connect the signal that triggers when a song finishes
	$".".finished.connect(_on_music_finished)
	play_next_song()

func play_next_song():
	# If the queue is empty, refill it and shuffle
	if playlist.is_empty():
		playlist = playlist.duplicate()
		playlist.shuffle()
	
	# Pull the next song from the queue
	var next_track = playlist.pop_back()
	
	$".".stream = next_track
	$".".play()

func _on_music_finished():
	play_next_song()
