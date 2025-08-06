tool
extends RobotEmulation

func _process(delta):
	$Joint1/lower_connection.rotation.y = $Joint1/Joint2.JointValue/1.2
	$Joint1/Joint2/meshes_j2/upper_connection.rotation.y = -$Joint1/Joint2.JointValue/1.2/2.5 - 1.5708
