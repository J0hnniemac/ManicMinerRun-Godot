extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -600.0

@onready var animated_sprite = $AnimatedSprite2D
var level_container 
func _ready():
	level_container = get_node("/root/Game/Level1")
	print(level_container)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		var willy_feet = global_position
		willy_feet.y -= 64
		var ontile = level_container.to_local(willy_feet)
		
		print("gp :" + str(global_position))
		print("wp :" + str(willy_feet))
		print("ot :" + str(ontile))
		var tileid0 = level_container.get_cell_source_id(0,ontile)
		print(tileid0)
		var tileid1 = level_container.get_cell_source_id(1,ontile)
		print(tileid1)
		var tileid2 = level_container.get_cell_source_id(2,ontile)
		print(tileid2)
		print(global_position)
		print(ontile)

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

