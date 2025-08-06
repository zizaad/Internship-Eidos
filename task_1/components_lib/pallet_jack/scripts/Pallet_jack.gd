tool
extends Spatial

export(float, 0, 2000) var scale_of_fork = 1360 setget set_scale_of_fork
export(float, -50, 50) var degrees=0 setget set_degrees

func set_scale_of_fork(value):
	scale_of_fork = value
	if scale_of_fork > 400:
		var Rightfork = get_node_or_null("Base/Rfork") as MeshInstance
		if Rightfork:
			Rightfork.scale.x = scale_of_fork/1360
			Rightfork.translation.x = ((scale_of_fork-1)*680+555)/1360
		var Rightslope = get_node_or_null("Base/Rfork_slope_end") as MeshInstance
		if Rightslope:
			Rightslope.translation.x = ((scale_of_fork-1)*1360+1225)/1360
		var Leftfork = get_node_or_null("Base/Lfork") as MeshInstance
		if Leftfork:
			Leftfork.scale.x = scale_of_fork/1360
			Leftfork.translation.x = ((scale_of_fork-1)*680+555)/1360
		var Leftslope = get_node_or_null("Base/Lfork_slope_end") as MeshInstance
		if Leftslope:
			Leftslope.translation.x = ((scale_of_fork-1)*1360+1225)/1360

func set_degrees(value):
	degrees = value
	var handle_degrees = get_node_or_null("Base/jack_cylinder2/hinge") as MeshInstance
	if handle_degrees:
		#if (degrees < 91 && degrees > -11):
			handle_degrees.rotation_degrees.z=degrees
