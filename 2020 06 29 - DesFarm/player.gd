extends KinematicBody


var motion = Vector3()
var SPD = 2000


# Called when the node enters the scene tree for the first time.
func _ready():
	$MeshInstance.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.



func _unhandled_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x / 300)
		$Pivot.rotate_z(event.relative.y / 300)

func movement(delta):
	motion = Vector3()
	if Input.is_action_pressed("ui_up"):
		motion -= $Pivot/Camera.global_transform.basis.z * SPD * delta
	if Input.is_action_pressed("ui_down"):
		motion += $Pivot/Camera.global_transform.basis.z * SPD * delta
	if Input.is_action_pressed("ui_left"):
		motion -= $Pivot/Camera.global_transform.basis.x * SPD * delta
	if Input.is_action_pressed("ui_right"):
		motion += $Pivot/Camera.global_transform.basis.x * SPD * delta
	
	if not is_on_floor():
		motion.y -= (SPD * delta) / 1.2
	else:
		motion.y = 0
	
	move_and_slide(motion, Vector3.UP)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	pass
