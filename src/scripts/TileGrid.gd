extends Control

export(PackedScene) var tile

var rng = RandomNumberGenerator.new()

var grid: Array
var ready_to_spawn: Array = []
var mobs_to_spawn: Array = []

var width: int = 6
var height: int = 6
var tile_size: int = 34
var tile_types: Array = ["iron","wood","magic","nature"]

var active_tiles: Array

var bottom_checklist: Array
var top_checklist: Array

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
			new_tile.target_pos = Vector2(x*tile_size,y*tile_size)
			new_tile.x = x
			new_tile.y = y
			grid[x][y] = new_tile
			#temp_grid.append(new_tile)
			var try: int = 0
			var temp_type: String = tile_types[num]
			new_tile.set_type(temp_type)
			while(type_match(x,y,temp_type) and try < 100):
				num = rng.randi_range(0,tile_types.size()-1)
				temp_type = tile_types[num]
				new_tile.set_type(temp_type)
				try += 1
	$SummonButton.rect_position = Vector2((width+1)*tile_size,rect_position.y)

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
		#get data
		var tile_1 = active_tiles[0].get_data()
		var tile_2 = active_tiles[1].get_data()
		if is_valid(tile_1,tile_2):
			$moveSound.play()
			active_tiles[0].set_data(tile_2)
			active_tiles[1].set_data(tile_1)		
			grid[tile_1.x][tile_1.y] = active_tiles[1]
			grid[tile_2.x][tile_2.y] = active_tiles[0]
			check_for_units([tile_2,tile_2])
		for tile in active_tiles:
			tile.clear_pressed()
		active_tiles.clear()

func tile_slide(button: Object,dir: String) -> void:
	active_tiles.append(button)
	var tile_1 = active_tiles[0].get_data()
	match dir:
		"up":
			if tile_1.y-1 < 0:
				return
			active_tiles.append(grid[tile_1.x][tile_1.y-1])
		"right":
			if tile_1.x+1 > width-1:
				return
			active_tiles.append(grid[tile_1.x+1][tile_1.y])
		"down":
			if tile_1.y+1 > height-1:
				return
			active_tiles.append(grid[tile_1.x][tile_1.y+1])
		"left":
			if tile_1.x-1 < 0:
				return			
			active_tiles.append(grid[tile_1.x-1][tile_1.y])
	var tile_2 = active_tiles[1].get_data()
	if is_valid(tile_1,tile_2):
		$moveSound.play()
		active_tiles[0].set_data(tile_2)
		active_tiles[1].set_data(tile_1)		
		grid[tile_1.x][tile_1.y] = active_tiles[1]
		grid[tile_2.x][tile_2.y] = active_tiles[0]
		check_for_units([tile_2,tile_2])
	for tile in active_tiles:
		tile.clear_pressed()
	active_tiles.clear()			

func is_valid(tile_1: Dictionary,tile_2: Dictionary) -> bool:
	if tile_1.x == tile_2.x: # same row
		if tile_1.y == tile_2.y+1 or tile_1.y == tile_2.y-1:
			return true
	if tile_1.y == tile_2.y: # same column
		if tile_1.x == tile_2.x+1 or tile_1.x == tile_2.x-1:
			return true
	return false 

func check_for_units(tiles: Array) -> void:
	for tile in tiles:
		check_for_double(tile,"nature","peasant")
		check_for_double(tile,"wood","arrow")
		check_for_square(tile,"iron",["peasant","peasant"],"knight")
		check_for_square(tile,"magic",["fireball","fireball"],"mage")
		check_for_square(tile,"wood",["arrow","arrow"],"ram")
		check_for_triple(tile,"iron",["peasant","peasant"],"spear")
		check_for_triple(tile,"magic",["peasant","peasant"],"fireball")
		check_for_two_layer_square(tile,"magic","iron",["fireball","fireball"],"heavy")
		check_for_two_layer_square(tile,"nature","iron",["spear","peasant"],"woodwall")

func check_for_double(tile,resource,type):
	var first = grid[tile.x][tile.y]
	if first.type == resource:
		if tile.x+1 <= width-1:
			if first.type == grid[tile.x+1][tile.y].type and type != grid[tile.x+1][tile.y].active_type:
				highlight([first,grid[tile.x+1][tile.y]],type)
		if tile.x-1 >= 0:
			if first.type == grid[tile.x-1][tile.y].type and type != grid[tile.x-1][tile.y].active_type:
				highlight([first,grid[tile.x-1][tile.y]],type)

func check_for_triple(tile,resource,whitelist,type):
	var first = grid[tile.x][tile.y]
	var checklist = []
	if first.type == resource:
		#tile is leftmost
		if tile.x-2 >= 0:
			checklist.append(first)
			checklist.append(grid[tile.x-1][tile.y])
			checklist.append(grid[tile.x-2][tile.y])
			if check_list(checklist,resource,whitelist):
				highlight(checklist,type)
			checklist.clear()
		#tile is middle
		if tile.x-1 >= 0 and tile.x+1 <= width-1:
			checklist.append(first)
			checklist.append(grid[tile.x-1][tile.y])
			checklist.append(grid[tile.x+1][tile.y])
			if check_list(checklist,resource,whitelist):
				highlight(checklist,type)
			checklist.clear()
		#tile is rightmost
		if tile.x+2 <= width-1:
			checklist.append(first)
			checklist.append(grid[tile.x+1][tile.y])
			checklist.append(grid[tile.x+2][tile.y])
			if check_list(checklist,resource,whitelist):
				highlight(checklist,type)
			checklist.clear()

func check_for_two_layer_square(tile, b_type: String, t_type: String, whitelist: Array, unit_type: String):
	var first = grid[tile.x][tile.y]
	clear_checklists()
	if first.type != b_type and first.type != t_type:
		return
	#topright
	if tile.x+1 <= width-1 and tile.y+1 <= height-1:
		top_checklist.append(first)
		top_checklist.append(grid[tile.x+1][tile.y])
		bottom_checklist.append(grid[tile.x+1][tile.y+1])
		bottom_checklist.append(grid[tile.x][tile.y+1])
		if check_double_list(top_checklist, bottom_checklist, b_type,t_type,whitelist):
			top_checklist.append(bottom_checklist[0])
			top_checklist.append(bottom_checklist[1])
			highlight(top_checklist,unit_type)
		clear_checklists()
	#bottomright
	if tile.x+1 <= width-1 and tile.y-1 >= 0:
		bottom_checklist.append(first)
		bottom_checklist.append(grid[tile.x+1][tile.y])
		top_checklist.append(grid[tile.x+1][tile.y-1])
		top_checklist.append(grid[tile.x][tile.y-1])
		if check_double_list(top_checklist, bottom_checklist, b_type,t_type,whitelist):
			top_checklist.append(bottom_checklist[0])
			top_checklist.append(bottom_checklist[1])
			highlight(top_checklist,unit_type)
		clear_checklists()
	#bottomleft
	if tile.x-1 >= 0 and tile.y-1 >= 0:
		bottom_checklist.append(first)
		bottom_checklist.append(grid[tile.x-1][tile.y])
		top_checklist.append(grid[tile.x-1][tile.y-1])
		top_checklist.append(grid[tile.x][tile.y-1])
		if check_double_list(top_checklist, bottom_checklist, b_type,t_type,whitelist):
			top_checklist.append(bottom_checklist[0])
			top_checklist.append(bottom_checklist[1])
			highlight(top_checklist,unit_type)
		clear_checklists()
	#topleft
	if tile.x-1 >= 0 and tile.y+1 <= height-1:
		top_checklist.append(first)
		top_checklist.append(grid[tile.x-1][tile.y])
		bottom_checklist.append(grid[tile.x-1][tile.y+1])
		bottom_checklist.append(grid[tile.x][tile.y+1])
		if check_double_list(top_checklist, bottom_checklist, b_type,t_type,whitelist):
			top_checklist.append(bottom_checklist[0])
			top_checklist.append(bottom_checklist[1])
			highlight(top_checklist,unit_type)
		clear_checklists()

func clear_checklists():
	top_checklist.clear()
	bottom_checklist.clear()

func check_for_square(tile, type: String, whitelist: Array, unit_type: String):
	var first = grid[tile.x][tile.y]
	var checklist = []
	if first.type != type:
		return
	#topright
	if tile.x+1 <= width-1 and tile.y+1 <= height-1:
		checklist.append(first)
		checklist.append(grid[tile.x+1][tile.y])
		checklist.append(grid[tile.x+1][tile.y+1])
		checklist.append(grid[tile.x][tile.y+1])
		if check_list(checklist,type,whitelist):
			highlight(checklist,unit_type)
		checklist.clear()
	#bottomright
	if tile.x+1 <= width-1 and tile.y-1 >= 0:
		checklist.append(first)
		checklist.append(grid[tile.x+1][tile.y])
		checklist.append(grid[tile.x+1][tile.y-1])
		checklist.append(grid[tile.x][tile.y-1])
		if check_list(checklist,type,whitelist):
			highlight(checklist,unit_type)
		checklist.clear()
	#bottomleft
	if tile.x-1 >= 0 and tile.y-1 >= 0:
		checklist.append(first)
		checklist.append(grid[tile.x-1][tile.y])
		checklist.append(grid[tile.x-1][tile.y-1])
		checklist.append(grid[tile.x][tile.y-1])
		if check_list(checklist,type,whitelist):
			highlight(checklist,unit_type)
		checklist.clear()	
	#topleft
	if tile.x-1 >= 0 and tile.y+1 <= height-1:
		checklist.append(first)
		checklist.append(grid[tile.x-1][tile.y])
		checklist.append(grid[tile.x-1][tile.y+1])
		checklist.append(grid[tile.x][tile.y+1])
		if check_list(checklist,type,whitelist):
			highlight(checklist,unit_type)
		checklist.clear()	
		
func check_list(list: Array, type: String, whitelist: Array) -> bool:
	for item in list:
		if item.type != type:
			return false
	for item in list:
		if item.active_type != "none" and item.active_type != whitelist[0] and item.active_type != whitelist[1]:
			return false
	return true
	
func check_double_list(top_list: Array, bottom_list: Array, bottom_type: String, top_type: String, whitelist: Array) -> bool:
	for item in top_list:
		if item.type != top_type:
			return false
	for item in top_list:
		if item.active_type != "none":# and item.active_type != "peasant":
			return false
	for item in bottom_list:
		if item.type != bottom_type:
			return false
	for item in bottom_list:
		if item.active_type != "none":# and item.active_type != "peasant":
			return false
	return true
	
func highlight(tiles: Array, type: String) -> void:
	$succesSound.play()
	mobs_to_spawn.append(type)
	for tile in tiles:
		ready_to_spawn.append(tile)
		tile.highlight(type)

func _on_SummonButton_pressed():
	if !mobs_to_spawn.empty():
		for tile in ready_to_spawn:
			var i: int = 1
			while(tile.y-i > -1):
				var tile_1 = tile.get_data()
				var tile_2 = grid[tile_1.x][tile_1.y-i].get_data()
				tile.set_data(tile_2)
				grid[tile_1.x][tile_1.y-i].set_data(tile_1)		
				grid[tile_1.x][tile_1.y] = grid[tile_1.x][tile_1.y-i]
				grid[tile_2.x][tile_2.y] = tile
				#i += 1
			var num: int = rng.randi_range(0,tile_types.size()-1)
			var temp_type: String = tile_types[num]
			tile.set_type(temp_type)
			#tile.to_the_top()
		ready_to_spawn.clear()
		var spawners = get_tree().get_nodes_in_group("Spawner")
		print(mobs_to_spawn)
		spawners[0].spawn_list(mobs_to_spawn)
		#for mob in mobs_to_spawn:
			#spawners[0].spawn(mob)
		mobs_to_spawn.clear()
