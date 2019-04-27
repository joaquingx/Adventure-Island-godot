extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var lives = 3

# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	var lives_str = ' ' + str(lives)
	$RichTextLabel.clear()
	$RichTextLabel.add_text(lives_str)
	
func lose_live():
	lives -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
