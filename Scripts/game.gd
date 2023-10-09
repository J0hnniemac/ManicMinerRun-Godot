extends Node2D


#add new level

var current_level_id = 0

var max_level = 1

var level01 = preload("res://Scenes/level_01.tscn")
var level02 = preload("res://Scenes/level_02.tscn")
var player = preload("res://Scenes/player.tscn")
var collectable1 = preload("res://Scenes/collectable_hud_item_mover.tscn")
var current_level
var instance_level

#Globally Access Data (yeh I know I should use signal but hey it is my game)
var is_game_over = true



@onready var player_scene = preload("res://Scenes/player.tscn")
@onready var willy_life = preload("res://Scenes/willy_life.tscn")
@onready var hud = $CanvasLayer/HUD
#@onready var level_container = $Level1

var game_manager

var level

var collectable_count 

signal all_collectables_collected


func _ready():
	
	game_manager = get_node("/root/GameManager")
	current_level_id = game_manager.current_level_id
	if current_level_id == 0:
		RenderingServer.set_default_clear_color(Color.BLACK)
	if current_level_id == 1:
		RenderingServer.set_default_clear_color(Color.BLUE)
		
	#game_manager.reset_game()
	var levels = [level01,level02]
	current_level = levels[current_level_id]
	instance_level = current_level.instantiate()
	add_child(instance_level)
	var instance_player = player.instantiate()
	instance_player.global_position = instance_level.get_node("PlayerSpawnPoint").global_position
	add_child(instance_player)
	
	
	
	#spawn_player()
	#level = get_node("/root/Game/Level01")
	refresh_score()
	refresh_lives()
	init_lives_hud()
	
	#get all collectable and connect collectable_collected to collected_collectable
	#hook_up_collectables_emitter()
	
	
func hook_up_collectables_emitter():
	#print(get_stack()[0]["function"])
	var collectables_root
	if game_manager.current_level_id == 0:
		collectables_root = get_node("/root/Game/Level01/Collectables")
	if game_manager.current_level_id == 1:
		collectables_root = get_node("/root/Game/Level02/Collectables")
		
	collectable_count = collectables_root.get_child_count()
	game_manager.number_of_collectables = collectable_count
	for item in collectables_root.get_children():
		item.collectable_collected.connect(collected_collectable)
	
func collected_collectable(pos):
	print("spawn collectable at :" + str (pos.get_origin()))
	var instance = collectable1.instantiate()
	instance.global_position = pos.get_origin()
	hud.add_child(instance)	
	#print(get_stack()[0]["function"])
	game_manager.collected_item()
	refresh_score()
	
	collectable_count -= 1
	if collectable_count == 0:
		_all_collectables_collected()

func _all_collectables_collected():
	#print(get_stack()[0]["function"])
	all_collectables_collected.emit()
func refresh_score():
	$CanvasLayer/HUD/Score.text = str("%06d" % [game_manager.current_score])
	
func refresh_lives():
	$CanvasLayer/HUD/HighScore.text = str("%06d" % [game_manager.highest_score])
	
	
func willydied():
	if game_manager.just_died:
		return
	game_manager.just_died = true
	stop_sounds()
	$Player.stop_movement()
	$WillyDied.play()
	stop_movers()
	
	game_manager.willy_died()
	refresh_lives()
	
	
	await get_tree().create_timer(1).timeout
	game_manager.just_died = false
	check_for_game_over()
	
	
func play_fall():
	$FallSound.play()
func play_jump():
	$JumpSound.play()
	
func stop_sounds():
	$FallSound.stop()
	$JumpSound.stop()
	
func _process(_delta):	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

func start_player():
	print("need to start stuff")
	start_movers()
	play_fall()
func start_movers():
	#get level mover tree then do the business
	var movers_root = instance_level.get_node("Movers")
	for mover in movers_root.get_children():
		mover.move_robot()
func stop_movers():
	#get level mover tree then do the business
	var movers_root = instance_level.get_node("Movers")
	for mover in movers_root.get_children():
		mover.stop_robot()
		
func check_for_game_over():
	if game_manager.lives < 0:
		game_manager.reset_game()
		get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
	else:
		self.get_tree().reload_current_scene()
		
func init_lives_hud():
	for i in game_manager.lives:
		var willy = willy_life.instantiate()
		willy.position.y = 50
		willy.position.x = i * 48
		$CanvasLayer/HUD/WillyLivesHolder.add_child(willy)

		
