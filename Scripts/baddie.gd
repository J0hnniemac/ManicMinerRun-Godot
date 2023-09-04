extends Area2D




func _on_body_entered(body):
	print("Willy hit me")
	##get_tree().paused = true
	print("Do something else")
	
	get_tree().reload_current_scene()
