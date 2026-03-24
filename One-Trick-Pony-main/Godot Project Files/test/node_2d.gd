extends TextureRect

var noise = FastNoiseLite.new()

func _ready():
	NoiseTexture2D.new().noise = noise
