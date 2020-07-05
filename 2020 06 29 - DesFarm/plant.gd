extends Spatial

export(int) var growth = 0 
var max_growth = 5 - 1
export(bool) var watered = false
var is_player_touching = false

func _ready():
	if growth != 0 or watered != false:
		set_plant()
	pass


func set_plant():
	var w = 0
	if watered: 
		w = 1
	
	for c in $plants.get_child(w).get_child_count():
		print("plant called this")
		if c == growth:
			$plants.get_child(w).get_child(c).show()
			$plants.get_child(w).get_child(c).translation = Vector3.ZERO
		else:
			$plants.get_child(w).get_child(c).hide()
	pass

func grow_plant():
	if growth < max_growth:
		growth += 1
		watered = false
		set_plant()
	pass

func harvest_plant():
	growth = 0
	watered = false
	set_plant()
	pass


func _input(event):
	if is_player_touching:
		if Input.is_action_just_pressed("ui_accept"):
			grow_plant()
		if Input.is_action_just_pressed("ui_select"):
			harvest_plant()

func _on_Area_body_entered(body):
	if body.name == "player":
		is_player_touching = true
	pass # Replace with function body.


func _on_Area_body_exited(body):
	if body.name == "player":
		is_player_touching = false
	pass # Replace with function body.
