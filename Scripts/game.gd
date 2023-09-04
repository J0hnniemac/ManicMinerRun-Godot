extends Node2D

@onready var player_spawn_point = $PlayerSpawnPoint
@onready var player_scene = preload("res://Scenes/Player.tscn")

@onready var level_container = $Game


func _ready():
	spawn_player()

func spawn_player():
	var player_instance = player_scene.instantiate()
	print(player_spawn_point.global_position)
	player_instance.global_position = player_spawn_point.global_position
	add_child(player_instance)
	print("spawn_player")

