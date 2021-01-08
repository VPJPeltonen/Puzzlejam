extends Control

export(PackedScene) var tile

var rng = RandomNumberGenerator.new()

var grid: Array

var width: int = 6
var height: int = 6
var tile_size: int = 32
var tile_types: Array = ["iron","wood","magic","nature"]

var active_tiles: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	grid = make_2d_array()
	generate_grid()
	#$Tile.rect_position

func make_2d_array() -> Array:
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func generate_grid() -> void:
	for x in range(width):
		for y in range(height):
			var num: int = rng.randi_range(0,tile_types.size()-1)
			var new_tile = tile.instance()
			add_child(new_tile)
			new_tile.rect_position = Vector2(x*tile_size,y*tile_size)
			grid[x][y] = new_tile
			#temp_grid.append(new_tile)
			var try: int = 0
			var temp_type: String = tile_types[num]
			new_tile.set_type(temp_type)
			while(type_match(x,y,tile_types[num]) and try < 100):
				num = rng.randi_range(0,tile_types.size()-1)
				temp_type = tile_types[num]
				new_tile.set_type(temp_type)
				try += 1

func type_match(x,y,type) -> bool:
	if x > 1:
		if grid[x-1][y] != null:
			if grid[x-1][y].type != type:
				return false
	if y > 1:
		if grid[x][y-1] != null:
			if grid[x][y-1].type != type:
				return false
	return true

func button_clicked(button: Object) -> void:
	active_tiles.append(button)
	if active_tiles.size() >= 2:
		for tile in active_tiles:
			tile.clear_pressed()
		active_tiles.clear()
