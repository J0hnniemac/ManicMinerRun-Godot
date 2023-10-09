extends Control

 
func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	
 
func _on_level_1_pressed():
	var game_manager = get_node("/root/GameManager")
	game_manager.current_level_id = 0
	
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	
	


func _on_exit_pressed():
	get_tree().quit()


func _process(_delta):	
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_level_2_pressed():
	var game_manager = get_node("/root/GameManager")
	game_manager.current_level_id = 1
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

