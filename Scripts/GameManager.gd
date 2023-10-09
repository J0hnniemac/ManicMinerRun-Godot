extends Node2D

var current_score = 0
var highest_score = 0
var lives = 5
var just_died = false

var current_level_id = 0

var number_of_collectables = 0
func _ready():
	print("GameManager Ready")
	reset_game()
	
	
	
func reset_game():
	print("reset_game")
	if current_score > highest_score:
		highest_score = current_score
	current_score = 0
	lives = 5
	
func collected_item():
	current_score += 100
	print(str(current_score))

func willy_died():
	lives -= 1
	print(str(lives))
	
