extends Area2D

var is_flashing = false
var flash_timer_reset = 1
var flash_timer = flash_timer_reset
var flash_direction = 1
var alpha = 0.05

signal collectable_collected(tran)

func _ready():
	randomise_flash_start()
	
func randomise_flash_start():
	await get_tree().create_timer(randf_range(0.3, 1.0)).timeout
	is_flashing = true;
func _on_body_entered(_body):
	print("s:" + str(to_global($Sprite2D.position)))
	collectable_collected.emit($Sprite2D.get_global_transform())

	queue_free()

func _process(_delta):
	flash_collectable()
		
func flash_collectable():
	if !is_flashing:
		return
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
