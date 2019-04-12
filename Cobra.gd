extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const SPEED = 1000
var velocity = Vector2()
const GRAVITY = 500
var collision = false
var collision_times = 0

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
