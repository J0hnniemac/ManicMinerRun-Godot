extends TileMap

@onready var tilemap = $/root/Game/Level01
var baddie1 = preload("res://Scenes/baddie_1.tscn")
var baddie2 = preload("res://Scenes/baddie_2.tscn")
var collectable1 = preload("res://Scenes/collect_1.tscn")

func _ready():
	#tilemap = get_node("/root/Game/Level01")
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
		#print(i)
	

func replace_tile_with_sprite_at(grid_position:Vector2i, baddie_id:String):
	print("replace" + baddie_id + " :" + str(grid_position))
	tilemap.erase_cell(0,grid_position)
	var world_position = tilemap.map_to_local(grid_position)
	print("World Position at :" + str(world_position))
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
		add_child(instance)
	
	pass
