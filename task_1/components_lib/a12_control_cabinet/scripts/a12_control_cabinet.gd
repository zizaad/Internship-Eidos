tool
extends Spatial


export(bool) var opened = false setget set_opened, get_opened

func get_door_cupboard_joint() -> RcsToggleJoint:
	return $door_cupboard_joint as RcsToggleJoint

func set_opened(value):
	get_door_cupboard_joint().TogglePositive = value
	opened =  value

func get_opened():
	opened = get_door_cupboard_joint().TogglePositive
	return opened
