extends Spatial

# Player3PC (3rd Person Camera)

var settings = {
	"is_camera_inverted_x" : false,
	"is_camera_inverted_y" : false, 
}

var spd = 2000

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	movement(delta)
	controller_camera()
	pass

func movement(delta):
	if Input.is_action_pressed("ui_up"):
		global_transform.basis.z -= spd * delta
	if Input.is_action_pressed("ui_down"):
		global_transform.basis.z += spd * delta
	if Input.is_action_pressed("ui_left"):
		global_transform.basis.x -= spd * delta
	if Input.is_action_pressed("ui_right"):
		global_transform.basis.x += spd * delta
	pass

func _unhandled_input(event):
	# Camera movement
	if event is InputEventMouseMotion:
		mouse_camera(event)
	pass

func mouse_camera(event):
	if settings.is_camera_inverted_x:
		$pivot/pivot2.rotate_x(-event.relative.y / 100)
	else:
		$pivot/pivot2.rotate_x(event.relative.y / 100)
	if settings.is_camera_inverted_y:
		$pivot.rotate_y(-event.relative.x / 100)
	else:
		$pivot.rotate_y(event.relative.x / 100)
	pass

func controller_camera():
	var conx = Input.get_joy_axis(0, JOY_AXIS_2)
	var cony = Input.get_joy_axis(0, JOY_AXIS_3)
	var con = Vector2(conx, cony)
	if settings.is_camera_inverted_x:
		$pivot.rotate_y(-con.x / 100)
	else:
		$pivot.rotate_y(con.x / 100)	
	if settings.is_camera_inverted_y:
		$pivot/pivot2.rotate_x(-con.y / 100)
	else:
		$pivot/pivot2.rotate_x(con.y / 100)
	pass


