extends TileMap


@onready var tilemap = $/root/Game/Level01
var baddie1 = preload("res://Scenes/baddie_1.tscn")
var baddie2 = preload("res://Scenes/baddie_2.tscn")
var collectable1 = preload("res://Scenes/collect_1.tscn")
var portal = preload("res://Scenes/portal.tscn")
var sinky = preload("res://Scenes/sinky.tscn")

var collectables = Node2D.new()

var number_of_collectables = 0
signal all_collectables_collected

func _ready():
	#tilemap = get_node("/root/Game/Level01")
	
	# create empty collectables node
	
	collectables.name = "Collectables"
	add_child(collectables)
	
	replace_tiles_with_spite()
	
func replace_tiles_with_spite():
	var all_tile_zero_cells = tilemap.get_used_cells_by_id(0)
	for i in all_tile_zero_cells:
		var data = tilemap.get_cell_tile_data(0,i)
		if data:
			var tile_type = data.get_custom_data("TileType")
			#print(tile_type)
			if tile_type == "baddie1":	
				replace_tile_with_sprite_at(i,"baddie1")
			if tile_type == "baddie2":	
				replace_tile_with_sprite_at(i,"baddie2")
			if tile_type == "collectable1":
				replace_tile_with_sprite_at(i,"collectable1")
			if tile_type == "portal1":
				replace_tile_with_sprite_at(i,"portal")
			if tile_type == "sinkyfloor1":
				replace_tile_with_sprite_at(i,"sinky")
				
		#print(i)
	

func replace_tile_with_sprite_at(grid_position:Vector2i, baddie_id:String):
	#print("replace" + baddie_id + " :" + str(grid_position))
	tilemap.erase_cell(0,grid_position)
	var world_position = tilemap.map_to_local(grid_position)
	#print("World Position at :" + str(world_position))
	if baddie_id == "baddie1":
		var instance = baddie1.instantiate()
		instance.global_position = world_position
		add_child(instance)
	if baddie_id == "baddie2":
		var instance = baddie2.instantiate()
		instance.global_position = world_position
		add_child(instance)
	if baddie_id == "collectable1":
		var instance = collectable1.instantiate()
		instance.global_position = world_position
		collectables.add_child(instance)
		number_of_collectables += 1
	if baddie_id == "portal":
		tilemap.erase_cell(0,Vector2i(grid_position.x + 1,grid_position.y))
		tilemap.erase_cell(0,Vector2i(grid_position.x ,grid_position.y + 1))
		tilemap.erase_cell(0,Vector2i(grid_position.x + 1,grid_position.y + 1))
		var instance = portal.instantiate()
		instance.global_position = Vector2(world_position.x,world_position.y + 64)
		add_child(instance)
	if baddie_id == "sinky":
		print("sinky replaced")
		var instance = sinky.instantiate()
		instance.global_position = world_position
		add_child(instance)

	
		
	
	
	
	
