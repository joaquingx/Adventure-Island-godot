extends KinematicBody2D

var GRAVITY = 10
var FLOOR = Vector2(0, -1)


var velocity = Vector2()
var direction = 1
var is_dead = false

func is_dead():
	is_dead = true
	velocity = Vector2(10,0)
	$DeadSound.play()
	$AnimatedSprite.play('dead')
	$CollisionShape2D.call_deferred("set_disabled", true)
	velocity.y += -100
	$Timer.start()
	
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not is_dead: 
		$AnimatedSprite.play('normal')
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
	else:
		velocity.x = 30
		velocity.y += GRAVITY
		translate(velocity*delta)
		

func _on_Timer_timeout():
	queue_free() # Replace with function body.
