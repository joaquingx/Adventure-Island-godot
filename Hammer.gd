extends Area2D

const SPEED_X = 100
const SPEED_Y = 50
var velocity = Vector2()
var direction = 1

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	elif dir == 1:
		$AnimatedSprite.flip_h = false

func _ready():
	velocity.y -= 100

func _physics_process(delta):
	velocity.x = SPEED_X  * direction
	velocity.y += SPEED_Y/10
	translate(velocity*delta)
	$AnimatedSprite.play("attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Hammer_body_entered(body):
	if 'Snail' in body.name or 'Crow' in body.name:
		print(body.name)
		body.is_dead()
	queue_free()