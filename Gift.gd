extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2()
var is_open = false
var is_rendered = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if is_open and not is_rendered:
		velocity.y += 10
		velocity.x = 100
		$AnimatedSprite.play('open_egg')
		translate(velocity*delta)
	if is_rendered:
		$AnimatedSprite.play('hammer')
		
func _on_Area2D_body_entered(body):
	if 'Adventurer' in body.name and not is_rendered:
		is_open = true
		velocity.y -= 120
	if 'TileMap' in body.name and is_open:
		is_rendered = true
	if 'Adventurer' in body.name and is_rendered:
		$CollisionShape2D.call_deferred("set_disabled", true)
		body.get_armed()
		queue_free()
		
