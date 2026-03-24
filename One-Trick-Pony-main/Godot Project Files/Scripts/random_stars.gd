extends TileMapLayer

var tilemap_width: int = Global.screen_size.x / 3
var tilemap_height: int = Global.screen_size.y / 3

var noise = FastNoiseLite.new()

var stars = [
	{"column": 0, "rows": [0,1,2,3,4,5,6,7,8,9], "chance": 99.0}, 
	{"column": 1, "rows": [0,1,2,3,4], "chance": 0.800}, 
	{"column": 1, "rows": [5,6,7,8,9], "chance": 0.150}, 
	{"column": 2, "rows": [0,1,2,3,4], "chance": 0.40},  
	{"column": 4, "rows": [0,1,2,3,4], "chance": 10} 
]

func _ready():
	noise.seed = randi() # Randomize the seed
	noise.frequency = 0.01
	generate_galaxy()
	var noise_tex = NoiseTexture2D.new()
	noise_tex.width = 2560
	noise_tex.height = 1664
	noise_tex.noise = noise
	Global.test = true

func generate_galaxy():
	for x in range(tilemap_width):
		for y in range(tilemap_height):
			set_cell(Vector2i(x, y), 0, random_star())

func random_star() -> Vector2i:
	var current_sum = 0
	var random = randf() * 100
	
	for group in stars:
		current_sum += group["chance"]
		if random <= current_sum:
			return Vector2i(group["column"], group["rows"].pick_random())
	
	return Vector2i(1, 0)
