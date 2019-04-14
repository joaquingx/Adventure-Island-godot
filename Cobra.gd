extends KinematicBody2D


const SPEED = 1000
var velocity = Vector2()
const GRAVITY = 500
var collision = false
var collision_times = 0

func _ready():
	velocity.y = -100

func _physics_process(delta):
	velocity.x = SPEED * delta
	velocity.y += GRAVITY * delta
	collision = move_and_collide(velocity* delta)
	
	if collision:
		velocity = velocity.bounce(collision.normal)*0.7
		collision_times += 1
		if collision_times > 3:
			queue_free()
	$AnimatedSprite.play("shoot")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
