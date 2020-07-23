extends Spatial

var is_carried = false
var is_player_inside = false
var carrier = null

func _process(delta):
	if is_carried: 
		global_transform = carrier.get_node("carry").global_transform
#		rotation = carrier.get_node("carry").rotation
		pass

func _input(event):
	if is_player_inside:
		if Input.is_key_pressed(KEY_E):
			is_carried = !is_carried
			pass
	pass

func _on_Area_body_entered(body):
	if body.is_in_group("players"):
		is_player_inside = true
		carrier = body
	pass # Replace with function body.

func _on_Area_body_exited(body):
	if body.is_in_group("players"):
		is_player_inside = false
		pass
	pass # Replace with function body.
