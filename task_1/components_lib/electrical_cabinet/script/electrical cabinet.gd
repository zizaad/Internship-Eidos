tool
extends Spatial


export(float, 140, 600, 0.1) var height_mm = 382 setget set_height
export(float, 140, 600, 0.1) var width_mm = 282 setget set_width
export(float, 50, 600, 0.1) var depth_mm = 130 setget set_depth
export(bool) var opened = false setget set_opened, get_opened


func set_height(value):
	height_mm = value
	var hei1 = get_node_or_null("cabinet") as MeshInstance
	if hei1:
		hei1.translation.y = height_mm/2
		hei1.scale.y = height_mm/382
	var hei_door = get_node_or_null("door_cupboard_joint/door") as MeshInstance
	if hei_door:
		hei_door.translation.y = height_mm/2
		hei_door.scale.y = (height_mm-20)/342
	var hei_lock = get_node_or_null("door_cupboard_joint/lock") as MeshInstance 
	if hei_lock:
		hei_lock.translation.y = height_mm/2
	var hei_lightning0 = get_node_or_null("door_cupboard_joint/lightning0") as MeshInstance
	if hei_lightning0:
		hei_lightning0.translation.y = height_mm/2+40
	

func set_width(value):
	width_mm = value
	var wid1 = get_node_or_null("cabinet") as MeshInstance
	if wid1:
		wid1.translation.z = width_mm/2
		wid1.scale.z = width_mm/282
	var wid_door = get_node_or_null("door_cupboard_joint/door") as MeshInstance
	if wid_door:
		wid_door.translation.z = width_mm/2
		wid_door.scale.z = (width_mm-20)/242
	var wid_lock = get_node_or_null("door_cupboard_joint/lock") as MeshInstance 
	if wid_lock:
		wid_lock.translation.z = width_mm-40
	var wid_lightning0 = get_node_or_null("door_cupboard_joint/lightning0") as MeshInstance
	if wid_lightning0:
		wid_lightning0.translation.z = width_mm/2

func set_depth(value):
	depth_mm = value
	var dep1 = get_node_or_null("cabinet") as MeshInstance
	if dep1:
		dep1.translation.x = depth_mm/2*(-1)
		dep1.scale.x = depth_mm/130

func get_door_cupboard_joint() -> RcsToggleJoint:
	return $door_cupboard_joint as RcsToggleJoint

func set_opened(value):
	get_door_cupboard_joint().TogglePositive = value
	opened =  value

func get_opened():
	opened = get_door_cupboard_joint().TogglePositive
	return opened
