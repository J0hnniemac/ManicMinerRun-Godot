extends Node2D

@onready var player_spawn_point = $PlayerSpawnPoint
@onready var player_scene = preload("res://Scenes/Player.tscn")

@onready var level_container = $Level1


var level

var collectable_count 

signal all_collectables_collected

func _ready():
	
	spawn_player()
	level = get_node("/root/Game/Level01")
	
	
	#get all collectable and connect collectable_collected to collected_collectable
	hook_up_collectables_emitter()
	

func spawn_player():
	print(get_stack()[0]["function"])
	var player_instance = player_scene.instantiate()
	print(player_spawn_point.global_position)
	player_instance.global_position = player_spawn_point.global_position
	add_child(player_instance)
	print("spawn_player")
	
func hook_up_collectables_emitter():
	print(get_stack()[0]["function"])
	var collectables_root = get_node("/root/Game/Level01/Collectables")
	collectable_count = collectables_root.get_child_count()
	for item in collectables_root.get_children():
		item.collectable_collected.connect(collected_collectable)
	
func collected_collectable():
	print(get_stack()[0]["function"])
	collectable_count -= 1
	if collectable_count == 0:
		_all_collectables_collected()

func _all_collectables_collected():
	print(get_stack()[0]["function"])
	all_collectables_collected.emit()
	
