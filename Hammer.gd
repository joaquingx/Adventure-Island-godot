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

func update_score(mob):
	for index in get_parent().get_child_count():
		if 'ParallaxBackground' in get_parent().get_child(index).name:
			var parallax = get_parent().get_child(index)
			for index2 in parallax.get_child_count():
				if 'Score' in parallax.get_child(index2).name:
					if 'Crow' in mob:
						parallax.get_child(index2).score_crow()
					if 'Snail' in mob:
						parallax.get_child(index2).score_snail()

func _on_Hammer_body_entered(body):
	if 'Snail' in body.name or 'Crow' in body.name:
		update_score(body.name)
		body.is_dead()
	queue_free()