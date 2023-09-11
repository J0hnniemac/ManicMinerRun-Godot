extends Area2D

@export var direction = 1 
@export var move_distance = 32 * 8
var flip = 1

var start_x_global
var end_x_global
var speed = 128
var time_to_move = 0

func _ready():
	#todo fix speed time = distance / speed
	
	time_to_move =  speed / time_to_move
	
	start_x_global = global_position.x
	
	if direction == 1:
		
		
		end_x_global = start_x_global + move_distance
	else:
		
		end_x_global = start_x_global - move_distance
		
		
		
	move_robot()
	
	#start_moving(robot_max_world.x,robot_min_world.x)
	

	
func move_robot():
	var tween = create_tween()
	if direction == 1:
		tween.tween_property($Sprite2D,"flip_h",false,0)
		tween.tween_property(self, "position:x", end_x_global, time_to_move)
		tween.tween_property($Sprite2D,"flip_h",true,0)
		tween.tween_property(self, "position:x", start_x_global, time_to_move)
	else:
		tween.tween_property($Sprite2D,"flip_h",true,0)
		tween.tween_property(self, "position:x", end_x_global, time_to_move)
		tween.tween_property($Sprite2D,"flip_h",false,0)
		tween.tween_property(self, "position:x", start_x_global, time_to_move)
	
	tween.tween_callback(move_robot)
