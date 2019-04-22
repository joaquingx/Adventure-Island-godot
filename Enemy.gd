extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30 
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var is_dead = false

func is_dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play('dead')
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	#queue_free()
	
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not is_dead:
		velocity.x = SPEED * direction 
		$AnimatedSprite.play('run')
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
		
		
		if is_on_wall():
			direction *= -1
			$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
			$RayCast2D.position.x *=-1
			
		if not $RayCast2D.is_colliding():
			direction *= -1
			$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
			$RayCast2D.position.x *=-1
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Adventurer" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()

func _on_Timer_timeout():
	queue_free() # Replace with function body.
