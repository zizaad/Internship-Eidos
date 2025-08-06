tool
extends Spatial

export(bool) var sit = false setget set_sit1

func set_sit1(value):
	sit = value
	if sit:
		var firsthip = get_node_or_null("shin/hip") as MeshInstance
		if firsthip:
			firsthip.translation.z = -2842
			firsthip.translation.y = 1389.9
			firsthip.rotation_degrees.x=80.963
			firsthip.scale.y = 1.648
			firsthip.scale.z = 0.629
		var secondtorso = get_node_or_null("shin/hip/torso_standing") as MeshInstance
		if secondtorso:
			secondtorso.translation.z =1168.3
			secondtorso.translation.y = 616.25
			secondtorso.rotation_degrees.x=-86.52
			secondtorso.scale.y = 1.5
			secondtorso.scale.z = 0.6
		var thirdhands = get_node_or_null("shin/hip/torso_standing/hands_standing") as MeshInstance
		if thirdhands:
			thirdhands.translation.z =-40.236
			thirdhands.translation.y = -77.673
			thirdhands.rotation_degrees.x=3.085
			thirdhands.scale.y = 1
			thirdhands.scale.z = 1
	else:
		var firsthip = get_node_or_null("shin/hip") as MeshInstance
		if firsthip:
			firsthip.translation.z =0
			firsthip.translation.y = 0
			firsthip.rotation_degrees.x=0
			firsthip.scale.y = 1
			firsthip.scale.z = 1
		var secondtorso = get_node_or_null("shin/hip/torso_standing") as MeshInstance
		if secondtorso:
			secondtorso.translation.z =-44.30
			secondtorso.translation.y = 183.45
			secondtorso.rotation_degrees.x=0
			secondtorso.scale.y = 1
			secondtorso.scale.z = 1
		var thirdhands = get_node_or_null("shin/hip/torso_standing/hands_standing") as MeshInstance
		if thirdhands:
			thirdhands.translation.z =173.94
			thirdhands.translation.y = 22.13
			thirdhands.rotation_degrees.x=-87.96
			thirdhands.scale.y = 1.683
			thirdhands.scale.z = 0.596
