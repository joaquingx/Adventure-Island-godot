extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dict = {
1: ['apple', 50],
2: ['banana', 100],
3: ['peach', 150],
4: ['carrot', 100]
}
var score = 0
var sprite = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var choose = randi()%4+1
	sprite = dict[choose][0]
	score = dict[choose][1]
	$AnimatedSprite.play(sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func update_score():
	for index in get_parent().get_child_count():
		if 'ParallaxBackground' in get_parent().get_child(index).name:
			var parallax = get_parent().get_child(index)
			for index2 in parallax.get_child_count():
				if 'Score' in parallax.get_child(index2).name:
					parallax.get_child(index2).score_fruit(score)

func _on_Fruit_body_entered(body):
	if 'Adventurer' in body.name:
		update_score()
		queue_free()
