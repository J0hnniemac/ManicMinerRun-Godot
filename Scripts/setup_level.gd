extends TileMap

@onready var tilemap = $/root/Game/Level01
func _ready():
	#tilemap = get_node("/root/Game/Level01")
	replace_tile_baddies()
	
func replace_tile_baddies():
	var all_tile_zero_cells = tilemap.get_used_cells_by_id(0)
	for i in all_tile_zero_cells:
		var data = tilemap.get_cell_tile_data(0,i)
		if data:
			var tile_type = data.get_custom_data("TileType")
			#print(tile_type)
			if tile_type == "baddie1":
				
				replace_baddie_at(i,"baddie1")
		#print(i)
	

func replace_baddie_at(grid_position:Vector2i, baddie_id:String):
	print("replace baddie1 at :" + str(grid_position))
	pass
