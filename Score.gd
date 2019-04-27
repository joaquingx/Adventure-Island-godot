extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func score_crow():
	score += 100
func score_snail():
	score += 50

func score_fruit(points):
	score += points

func _physics_process(delta):
	clear()
	var score_str = ' ' + str(score)
	add_text(score_str)
	