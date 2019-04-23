extends KinematicBody2D

var SPEED_Y = 1000
const SPEED_X = -1000
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var is_dead = false
var initial_position = 0

func is_dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play('dead')
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	#queue_free()
	
func _ready():
	initial_position = get_position()
	pass # Replace with function body.

func _physics_process(delta):
	#print(get_position())
	if not is_dead:
		velocity.x += SPEED_X 
		$AnimatedSprite.play('normal')
		velocity.y += SPEED_Y
		
		velocity = move_and_slide(velocity*delta, FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				#print(get_slide_collision(i).collider.name)
				if "Adventurer" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()
				if "TileMap" in get_slide_collision(i).collider.name:
					SPEED_Y = -SPEED_Y*1.1
		if get_position().y < initial_position.y:
			SPEED_Y = -SPEED_Y
	else:
		velocity.x = 100
		velocity.y += 10
		translate(velocity*delta)

func _on_Timer_timeout():
	queue_free() # Replace with function body.
