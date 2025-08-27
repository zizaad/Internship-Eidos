tool
extends RobotEmulation

var inited = false

var joint2
var joint3

var tube2
var tube3

func _ready():
	
	inited = true
	joint2 = get_node_or_null("Joint 1/Joint 2")
	joint3 = get_node_or_null("Joint 1/Joint 2/Joint 3")

	tube2 = get_node_or_null("Joint 1/tube")
	tube3 = get_node_or_null("Joint 1/Joint 2/tube")



func _process(delta):
	if inited:
		tube2.rotation.y = -(joint2.JointValue)/2
		tube3.rotation = Vector3(PI/2 + (joint3.JointValue)*0.8, -PI/2 - (joint3.JointValue)*0.2, -PI/2)
