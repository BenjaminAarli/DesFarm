extends Spatial


export(bool) var can_merge = false

var growth = 0
const max_growth = 5 - 1
var watered = false
var speed = 10 

var merged = 0


func _process(delta):
	if can_merge:
		merge()


func hide_all_plants():
	for c in get_node("plants").get_child_count():
		
		var m = merged * 5
		
		if c == growth + m:
			yield()
		elif get_node("plants").get_child(c).visible == true:
			get_node("plants").get_child(c).hide()
		pass

func merge():
	if $mergers/North.is_colliding() and $mergers/North.get_collider().name == "plant_straw":
		if merged == 0:
			$mergers/North.get_collider().get_owner().hide()
			get_node("plants/s_0").hide()
			get_node("plants/m_0").show()
			global_transform.origin.z += 1
			merged = 1
		if merged == 1: 
			$mergers/North.get_collider().get_owner().hide()
			get_node("plants/m_0").hide()
			get_node("plants/l_0").show()
			global_transform.origin.z += 3
			merged = 2
		pass
	elif $mergers/South.is_colliding() and $mergers/South.get_collider().get_class() == "plant_straw": 
		print("col")
#		print($mergers/North.get_collider().name)
	elif $mergers/West.is_colliding() and $mergers/West.get_collider().get_class() == "plant_straw": 
		print("col")
#		print($mergers/North.get_collider().name)
	elif $mergers/East.is_colliding() and $mergers/East.get_collider().get_class() == "plant_straw":  
		print("col")
#		print($mergers/North.get_collider().name)
	pass

