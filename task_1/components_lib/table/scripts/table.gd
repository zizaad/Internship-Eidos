tool
extends Spatial

export(float, 100, 1500, 0.1) var height_leg_mm = 800  setget set_height
func set_height(value):
	height_leg_mm = value
	var leg1 = get_node_or_null("leg1") as MeshInstance
	if leg1:
		leg1.scale.y = height_leg_mm/1000
		leg1.translation.y = height_leg_mm/2
	var leg2 = get_node_or_null("leg2") as MeshInstance
	if leg2:
		leg2.scale.y = height_leg_mm/1000
		leg2.translation.y = height_leg_mm/2
	var leg3 = get_node_or_null("leg3") as MeshInstance
	if leg3:
		leg3.scale.y = height_leg_mm/1000
		leg3.translation.y = height_leg_mm/2
	var leg4 = get_node_or_null("leg4") as MeshInstance
	if leg4:
		leg4.scale.y = height_leg_mm/1000
		leg4.translation.y = height_leg_mm/2
	var board = get_node_or_null("board") as Spatial
	if board:
		board.translation.y = height_leg_mm

export(float, 100, 3000, 0.1) var width_mm = 1000  setget set_width
func set_width(value):
	width_mm = value
	var leg1 = get_node_or_null("leg1") as MeshInstance
	if leg1:
		leg1.translation.x = -50+width_mm
	var leg2 = get_node_or_null("leg2") as MeshInstance
	if leg2:
		leg2.translation.x = -50+width_mm
	var board = get_node_or_null("board") as Spatial
	if board:
		board.scale.x = width_mm/1000
		board.translation.x = width_mm/2 

export(float, 100, 3000, 0.1) var depth_mm = 800  setget set_depth
func set_depth(value):
	depth_mm = value
	var leg2 = get_node_or_null("leg2") as MeshInstance
	if leg2:
		leg2.translation.z = 50-depth_mm
	#	leg2.translation.x = -50+depth_mm/2
	var leg4 = get_node_or_null("leg4") as MeshInstance
	if leg4:
		leg4.translation.z = 50-depth_mm
	#	leg4.translation.x = 50-depth_mm/2
	var board = get_node_or_null("board") as Spatial
	if board:
		board.scale.z = depth_mm/1000
		board.translation.z = - depth_mm/2 

export (Material) var board_material = preload("res://components_lib/table/materials/brown2.tres") setget set_board_material
func set_board_material(value):
	board_material = value
	var board_m = get_node_or_null("board/board") as MeshInstance
	if board_m:
		board_m.mesh.material = board_material
		board_m.set_surface_material(0, board_material)

export(Material) var leg_material = preload("res://components_lib/table/materials/brown2.tres") setget set_leg_material

func set_leg_material(value):
	leg_material = value
	var leg1_m = get_node_or_null("leg1") as MeshInstance
	var leg2_m = get_node_or_null("leg2") as MeshInstance
	var leg3_m = get_node_or_null("leg3") as MeshInstance
	var leg4_m = get_node_or_null("leg4") as MeshInstance
	if leg1_m:
		leg1_m.set_surface_material(0, leg_material)
		leg2_m.set_surface_material(0, leg_material)
		leg3_m.set_surface_material(0, leg_material)
		leg4_m.set_surface_material(0, leg_material)
