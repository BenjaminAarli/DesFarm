extends KinematicBody

var _tool = 0
var motion = Vector3()
var SPD = 1000

func ui(t = ""):
	$UI/Label.text = t

func _ready():
	$hideonload.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

	$placement.hide()
	pass # Replace with function body.


func change_tool():
	if Input.is_key_pressed(KEY_0):
		$placement.hide()
		get_parent().get_node("placement").hide()
		_tool = 0
	if Input.is_key_pressed(KEY_1):
		_tool = 1
		$placement.show()
		get_parent().get_node("placement").show()

func _unhandled_input(event):
	change_tool()
	# Pause the game with ESCAPE
	if Input.is_action_just_pressed("pause"):
		var p = load("res://scn_pause.tscn")
		# Reminder! Pause has it's own scene!
		get_tree().get_root().get_child(0).add_child(p.instance())
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
	# Camera Movement using Mouse
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x / 300)
		$Pivot.rotate_z(event.relative.y / 300)
	if Input.is_mouse_button_pressed(1):
		if _tool == 1:
			hoe()
		pass


var p = {
	"base" : preload("res://plants/plant.tscn"),
}

func placement():
	var xe = get_parent().get_node("placement")
	xe.transform.origin.z = stepify($placement.global_transform.origin.z-1, 4)
	xe.transform.origin.x = stepify($placement.global_transform.origin.x-1, 4)
	xe.global_transform.origin.y = 0

func hoe():
	var grass = p.base.instance()
	grass.transform.origin.z = stepify($placement.global_transform.origin.z-1, 4)
	grass.transform.origin.x = stepify($placement.global_transform.origin.x-1, 4)
	grass.transform.origin.y = -0.2
	get_parent().add_child(grass)
	pass

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
		motion.y -= (SPD * delta) / 1.2 # Basic Gravity
	else:
		motion.y = 0
	move_and_slide(motion, Vector3.UP)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)
	placement()
	pass
