extends Area2D

@export var direction = 1 
@export var move_distance = 32 * 8
var flip = 1

var start_x_global
var end_x_global
var speed = 140.0
var time_to_move 

var tween

func _ready():
	#todo fix speed time = distance / speed
	
	time_to_move =   move_distance / speed
	#print ("speed:" + str(speed) + " move_distance:" + str(move_distance))
	#print("time to move" + str(time_to_move))
	
	#var world_position = #
	start_x_global = self.get_global_position().x
	
	
	if direction == 1:
		
		
		end_x_global = start_x_global + move_distance
	else:
		
		end_x_global = start_x_global - move_distance
	
	#start_moving(robot_max_world.x,robot_min_world.x)
	$Sprite2D.texture.pause = false

	
func move_robot():
	
	tween = create_tween()	
	if direction == 1:
		tween.tween_property($Sprite2D,"flip_h",false,0)
		tween.tween_property(self, "global_position:x", end_x_global, time_to_move)
		tween.tween_property($Sprite2D,"flip_h",true,0)
		tween.tween_property(self, "global_position:x", start_x_global, time_to_move)
	else:
		tween.tween_property($Sprite2D,"flip_h",true,0)
		tween.tween_property(self, "global_position:x", end_x_global, time_to_move)
		tween.tween_property($Sprite2D,"flip_h",false,0)
		tween.tween_property(self, "global_position:x", start_x_global, time_to_move)
	
	tween.tween_callback(move_robot)


func _on_body_entered(_body):
	
	$"/root/Game".willydied()
	
	
func stop_robot():
	tween.stop()
	$Sprite2D.texture.pause = true
	
	
