extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

var SPEED = 60
const EXTRA_SPEED = 40
const GRAVITY = 10
const JUMP_POWER = -180
const FLOOR = Vector2(0, -1)
const HAMMER = preload("res://Hammer.tscn")


var velocity = Vector2()
var jump_times = 0

var is_dead = false
var is_trip = false
var is_throw =  false
var is_skate = false
var is_armed = false

func is_on_limits():
	var left_limit = $Camera2D.get_camera_screen_center().x - 160
	if position.x-5 < left_limit:
		return false
	return true

func is_on_time():
	var time_left = 10
	for index in get_parent().get_child_count():
		if 'ParallaxBackground' in get_parent().get_child(index).name:
			var parallax = get_parent().get_child(index)
			for index2 in parallax.get_child_count():
				if 'Time' in parallax.get_child(index2).name:
					time_left = parallax.get_child(index2).get_time()
	return time_left > 0
	
func _physics_process(delta):
	if not is_dead and not is_on_time():
		dead()
	if not is_dead and not is_trip and not is_throw:
		$Camera2D.limit_left = $Camera2D.get_camera_screen_center().x - 160
		if Input.is_action_pressed('ui_right'):
			velocity.x = SPEED
			$AnimatedSprite.flip_h = false
			if not is_skate:
				$AnimatedSprite.play('run')
			else:
				$AnimatedSprite.play('skate')
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed('ui_left') and is_on_limits():
			velocity.x = -SPEED
			$AnimatedSprite.flip_h = true
			if not is_skate:
				$AnimatedSprite.play('run')
			else:
				$AnimatedSprite.play('skate')
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			velocity.x = 0
			if is_on_floor():
				if not is_skate:
					$AnimatedSprite.play('idle')
				else:
					$AnimatedSprite.play('skate')
		if Input.is_action_just_pressed('ui_up') and jump_times < 1:
			$JumpSound.play()
			velocity.y = JUMP_POWER
			jump_times += 1			
				
		if is_on_floor():
			jump_times = 0
		else:
			if not is_skate:
				$AnimatedSprite.play('jump')
			else:
				$AnimatedSprite.play('skate')
			
		if Input.is_action_just_pressed("alternative_shoot"):
			if is_armed:
				var hammer = HAMMER.instance()
				hammer.set_fireball_direction(sign($Position2D.position.x))
					
				get_parent().add_child(hammer)
				hammer.position = $Position2D.global_position
				throw()		
			
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity, FLOOR)
	
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				#print(get_slide_collision(i).collider.name)
				if "Snail" in get_slide_collision(i).collider.name:
					dead()
				if "Rock" in get_slide_collision(i).collider.name:
					$RockSound.play()
					get_slide_collision(i).collider.dead()
					trip()
	if is_trip:
		velocity.y += GRAVITY
		velocity.x = 60
		velocity = move_and_slide(velocity, FLOOR)
	if is_throw:
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_dead:
		velocity.y += 10
		velocity.x = 2
		velocity = move_and_slide(velocity)
	
	print('Adventurer' + str(position))
	print('Camera:' + str($Camera2D.get_camera_screen_center()))

func trip():
	is_trip = true
	$AnimatedSprite.play('trip')
	velocity.y += -200
	$Timer2.start()


func update_lives():
	for index in get_parent().get_child_count():
		if 'ParallaxBackground' in get_parent().get_child(index).name:
			var parallax = get_parent().get_child(index)
			for index2 in parallax.get_child_count():
				if 'Lives' in parallax.get_child(index2).name:
					parallax.get_child(index2).lose_live()
func dead():
	is_dead = true
	velocity.y += -150
	update_lives()
	for index in range(get_parent().get_child_count()):
		if "AudioStream" in get_parent().get_child(index).name:
			get_parent().get_child(index).stop()
	$DeadSound.play()
	$AnimatedSprite.play('dead')
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Timer.start()
	
func throw():
	is_throw = true
	$HammerSound.play()
	if not is_skate:
		$AnimatedSprite.play('throw')
	$Timer3.start()

func get_skate():
	is_skate = true
	SPEED += EXTRA_SPEED*8
	$AnimatedSprite.play('skate')
	
func get_armed():
	is_armed = true

func _on_Timer_timeout():
	print('entre aca')
	if 	get_tree().change_scene('res://TitleScreen.tscn') != 0:
		print('Cant open file')


func _on_Timer2_timeout():
	is_trip = false


func _on_Timer3_timeout():
	is_throw = false
