extends StaticBody2D



		

func _on_area_2d_body_entered(body):
	print("on sinky")
	var tween = create_tween()
	tween.tween_property($Sprite2D,"frame",1,0.1)
	tween.tween_property($Sprite2D,"frame",2,0.2)
	tween.tween_property($Sprite2D,"frame",3,0.3)
	tween.tween_callback(queue_free)
	
	#$Sprite2D.frame = 1
