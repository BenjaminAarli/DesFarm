extends Spatial


var watered = false
var growth = 0

var plant = [
	load("res://plants/straw/growth0.png"),
	load("res://plants/straw/growth1.png"),
	load("res://plants/straw/growth2.png"),
	load("res://plants/straw/growth3.png"),
	load("res://plants/straw/growth4.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func grow():
	growth += 1
	if growth >= plant.size():
		growth = 0
	
	for c in $sprite.get_child_count():
		$sprite.get_child(c).texture = plant[growth]



func _on_Timer_timeout():
	grow()
	$Timer.start(5)
	pass # Replace with function body.
