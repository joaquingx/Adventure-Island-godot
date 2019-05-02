extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var time = 10

func str_time():
	var str_final = ''
	for i in range(time):
		str_final += 'I'
	return str_final
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.

func _physics_process(delta):
	clear()
	add_text(str_time())

func delete_time(x):
	time -= x	

func get_time():
	return time

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	delete_time(1)
