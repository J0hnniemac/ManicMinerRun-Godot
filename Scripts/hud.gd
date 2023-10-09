extends CanvasLayer

@onready var game_manager = $/root/GameManager
@onready var collectable_hud_item = preload("res://Scenes/collectable_hud_item.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	update_collectables()
	

func update_collectables():
	var collectables_holder = $CollectablesHolder
	var number_of_collectables = 5
	var gap_offset = 64
	var gap = 64
	for i in number_of_collectables:
		var instance = collectable_hud_item.instantiate()
		
		instance.global_position = Vector2i(gap_offset + (gap * i),-40)
		instance.set_modulate(Color(1,1,1,.3))
		collectables_holder.add_child(instance)
	

func collect_item(pos):
	print("spawn collected card")
	var instance = collectable_hud_item.instantiate()
	instance.global_position = pos.get_origin()
	#hud.add_child(instance)	
	queue_free()
