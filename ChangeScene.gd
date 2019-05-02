extends Area2D

export(String, FILE, "*.tscn") var target_stage

func _ready():
	pass # Replace with function body.




func _on_ChangeScene_body_entered(body):
	if "Adventurer" in body.name:
		get_tree().change_scene(target_stage)
