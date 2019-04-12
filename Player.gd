extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

const SPEED = 60
const GRAVITY = 10
const JUMP_POWER = -180
const FLOOR = Vector2(0, -1)
const FIREBALL = preload("res://Cobra.tscn")


var velocity = Vector2()
var jump_times = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed('ui_right'):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play('run')
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play('run')
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite.play('idle')
			
	# double jump
	if Input.is_action_just_pressed('ui_up') and jump_times < 1:
		velocity.y = JUMP_POWER
		jump_times += 1
	
	if Input.is_action_just_pressed("ui_accept"):
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		
		
	
	if is_on_floor():
		jump_times = 0
	else:
		$AnimatedSprite.play('jump')
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
