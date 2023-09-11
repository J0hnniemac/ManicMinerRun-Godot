extends Area2D
@export var is_flashing = false
@export var flash_timer_reset = 1
var flash_timer = flash_timer_reset
var flash_direction = 1
var alpha = 0.05

func _ready():
	var game = get_node("/root/Game")
	print("node:" + game.name)
	game.all_collectables_collected.connect(_all_collectables_collected)
	
	
	

	
	
func _all_collectables_collected():
	print("Key Collected")
	make_portal_flash()
func make_portal_flash():
	is_flashing = true

func _process(delta):
	
	flash_portal()
	
func flash_portal():
	if !is_flashing: return
	if flash_direction > 0:
		alpha = alpha + 0.01
	if alpha > 1: 
		alpha = 1
		flash_direction = -1
	if flash_direction < 0:
		alpha = alpha - 0.01
	if alpha < 0.25: 
		alpha = 0.25
		flash_direction = 1
	
	
	var sprite2d = $Sprite2D
	sprite2d.modulate = Color(1,1,1,alpha)
