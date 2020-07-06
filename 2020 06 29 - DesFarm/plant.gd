extends Spatial

var growth = 0 
const max_growth = 5 - 1 # 5 - 1 means 4 + empty plant.
var watered = false
var is_player_touching = false
var grow_time = 10

func _ready():
	if growth != 0 or watered != false:
		set_plant()
	pass

func seed_plant():
	if growth == 0: # Empty plant
		growth = 1  # Seeded Plant
		set_plant() # Change Model
	pass

func start_growing():
	$Timer.start(grow_time)

func set_plant():
	var w = 0
	if watered: 
		w = 1
	
	if growth == 1:
		start_growing()
	
	for c in $plants.get_child_count():
		for cc in $plants.get_child(c).get_child_count():
			$plants.get_child(c).get_child(cc).hide()
	
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
	growth = 0 # Empty Plant
	watered = false
	set_plant()
	pass

func _input(event):
	if is_player_touching:
		if Input.is_action_just_pressed("ui_accept"):
			seed_plant()
		if Input.is_action_just_pressed("ui_select"):
			harvest_plant()

func _on_Area_body_entered(body):
	if body.name == "player":
		is_player_touching = true
		watered = true
		if body.has_node("UI/Label"):
			if growth == max_growth:
				body.get_node("UI/Label").text = "Press SPACE to harvest!"
			else:
				body.get_node("UI/Label").text = "Press E to plant seed"
	pass # Replace with function body.

func _on_Area_body_exited(body):
	if body.name == "player":
		is_player_touching = false
		if body.has_node("UI/Label"):
			body.get_node("UI/Label").text = ""
	pass # Replace with function body.


func _on_Timer_timeout():
	if growth != max_growth:
		growth += 1
		set_plant()
		$Timer.start(grow_time)
	else:
		$Timer.stop()
	pass # Replace with function body.
