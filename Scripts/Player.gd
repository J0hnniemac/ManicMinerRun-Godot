extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -600.0

var jump_start_height = 0
var last_on_floor_height = 0
@onready var animated_sprite = $AnimatedSprite2D

var game
var running = false
var life_over = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_falling = true # start falling into scene
var is_jumping = false # start not jumping

func _ready():
	game = get_node("/root/Game")
	
	
	


func _physics_process(delta):
	if life_over:
		return
	if !running:
		if Input.is_action_pressed("ui_accept"):
			running = true
			game.start_player()
			
		return
	if is_jumping:
		if global_position.y > jump_start_height:
			is_falling = true
	
	
	if is_on_floor():
		is_falling = false
		is_jumping = false
		last_on_floor_height = global_position.y
		game.stop_sounds()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if global_position.y > last_on_floor_height:
			if !is_falling:
				game.play_fall()
			
			is_falling = true
			
			
#		var willy_feet = global_position
#		willy_feet.y -= 64
	

	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_start_height = global_position.y
		is_jumping = true
		game.play_jump()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = 1 #= Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if is_falling:
		velocity.x = 0
		animated_sprite.stop()
		
		
	move_and_slide()
	
	
func stop_movement():
	life_over = true
	$AnimatedSprite2D.pause()
	
	

		

