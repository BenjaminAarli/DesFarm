extends Control


func _input(event):
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		# Yield is used because without it... 
		# ...pressing pause will un-pause immedietly. 
		yield(get_tree().create_timer(.01), "timeout")
		get_tree().paused = false
		queue_free()
		pass

func _on_QuitGame_pressed():
	get_tree().quit()
	pass # Replace with function body.
