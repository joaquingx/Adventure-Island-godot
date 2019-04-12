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
const COBRA = preload("res://Cobra.tscn")
const FIREBALL = preload("res://Fireball.tscn")


var velocity = Vector2()
var jump_times = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed('ui_right'):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play('run')
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play('run')
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite.play('idle')
	if Input.is_action_just_pressed('ui_up') and jump_times < 1:
		velocity.y = JUMP_POWER
		jump_times += 1			
	
	if Input.is_action_just_pressed("ui_accept"):
		var cobra = COBRA.instance()
		get_parent().add_child(cobra)
		$AnimatedSprite.play('throw')
		cobra.position = $Position2D.global_position
	
	if Input.is_action_just_pressed("alternative_shoot"):
		var fireball = FIREBALL.instance()
		fireball.set_fireball_direction(sign($Position2D.position.x))
			
		get_parent().add_child(fireball)
		$AnimatedSprite.play('throw')
		fireball.position = $Position2D.global_position
			
	if is_on_floor():
		jump_times = 0
	else:
		$AnimatedSprite.play('jump')
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)