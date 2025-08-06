tool
extends Spatial

export (int, 100, 700) var pedestal_width = 350 setget set_pedestal_width, get_pedestal_width
export (int, 100, 2000) var pedestal_height = 350 setget set_pedestal_height, get_pedestal_height

export (int, 3, 50) var faceplate_width = 10 setget set_faceplate_width, get_faceplate_width
export (int, 50, 500) var faceplate_radius = 140 setget set_faceplate_radius, get_faceplate_radius

export (int, 3, 50) var support_width = 5 setget set_support_width, get_support_width
export (int, 100, 1000) var support_size = 500 setget set_support_size, get_support_size

export (int, 20, 1920) var panel_yaxis_movement = 50 setget set_panel_yaxis_movement, get_panel_yaxis_movement
export (float, 1.0, 2.1, 0.1) var panel_scale = 1.0 setget set_panel_scale, get_panel_scale
export (bool) var panel = true setget set_panel, get_panel

export (int, 50, 1950) var grille_yaxis_movement = 60 setget set_grille_yaxis_movement, get_grille_yaxis_movement
export (float, 1.0, 5.5, 0.1) var grille_scale = 5 setget set_grille_scale, get_grille_scale
export (bool) var grille = true setget set_grille, get_grille

export (bool) var gussets = true setget set_gussets, get_gussets
export (bool) var cylinder = false setget set_cylinder, get_cylinder

export (Material) var material = preload('res://components_lib/v_positioner/materials//main.material') setget set_material, get_material

var last_toggle: bool
var changed: bool
var spatial: Spatial
var last_change_timestamp: int
var loaded = false
func get_spatial():
	return get_node_or_null("Spatial")

func set_panel_scale(value: float) -> void:
	panel_scale = value
	var panel = get_node_or_null("Spatial/panel") as Spatial
	if panel:
		panel.scale = Vector3(1, panel_scale, panel_scale)

func get_panel_scale() -> float:
	return panel_scale

func set_grille_scale(value: float) -> void:
	grille_scale = value
	var grille = get_node_or_null("Spatial/grille")
	if grille:
		grille.scale = Vector3(grille_scale/5,grille_scale/5,5)

func get_grille_scale() -> float:
	return grille_scale

func set_panel_yaxis_movement(value: int) -> void:
	if value >= pedestal_height - 30:
		value = pedestal_height - 31
	panel_yaxis_movement = value
	var panel = get_node_or_null("Spatial/panel")
	panel.translation = Vector3(0.5 * pedestal_width - 1,panel_yaxis_movement + support_width, 0)

func get_panel_yaxis_movement() -> int:
	return panel_yaxis_movement

func set_grille_yaxis_movement(value: int) -> void:
	if value >= pedestal_height - 45:
		value = pedestal_height - 46
	grille_yaxis_movement = value
	var grille = get_node_or_null("Spatial/grille")
	if grille:
		grille.translation = Vector3(-0.5 * pedestal_width + 23,grille_yaxis_movement + support_width, 0)

func get_grille_yaxis_movement() -> int:
	return grille_yaxis_movement

func set_material(value: Material) -> void:
	material = value

func get_material() -> Material:
	return material

func change_gusset():
	var ped = get_node_or_null("Spatial/Pedestal/pedestal")
	var cyl = get_node_or_null("Spatial/cylinder/cylinder")
	var kosx1 = get_node_or_null("Spatial/gusset/xkos1/MeshInstance")
	var kosx2 = get_node_or_null("Spatial/gusset/xkos1/MeshInstance2")
	var kosx11 = get_node_or_null("Spatial/gusset/xkos2/MeshInstance")
	var kosx22 = get_node_or_null("Spatial/gusset/xkos2/MeshInstance2")
	var kosx3 = get_node_or_null("Spatial/gusset/zkos1/MeshInstance")
	var kosx4 = get_node_or_null("Spatial/gusset/zkos1/MeshInstance2")
	var kosx31 = get_node_or_null("Spatial/gusset/zkos2/MeshInstance")
	var kosx41 = get_node_or_null("Spatial/gusset/zkos2/MeshInstance2")
	var arr = [kosx1, kosx2, kosx11, kosx22,kosx3, kosx4, kosx31, kosx41]
	var meshin1 = get_node_or_null("Spatial/cylgusset/MeshInstance")
	var meshin2 = get_node_or_null("Spatial/cylgusset/MeshInstance2")
	var meshin3 = get_node_or_null("Spatial/cylgusset/MeshInstance3")
	var meshin4 = get_node_or_null("Spatial/cylgusset/MeshInstance4")
	var meshin5 = get_node_or_null("Spatial/cylgusset/MeshInstance5")
	var meshin6 = get_node_or_null("Spatial/cylgusset/MeshInstance6")
	var arrs = [meshin1, meshin2, meshin3, meshin4, meshin5, meshin6]
	
	if ped:
		if ped.visible and gussets:
			if arr and arrs:
				for i in range(0,len(arr)):
					arr[i].visible = true
				for i in range(0,len(arrs)):
					arrs[i].visible = false
		if cyl.visible and gussets:
			if arr and arrs:
				for i in range(0,len(arr)):
					arr[i].visible = false
				for i in range(0,len(arrs)):
					arrs[i].visible = true
		if !gussets:
			if arr and arrs:
				for i in range(0,len(arr)):
					arr[i].visible = false
				for i in range(0,len(arrs)):
					arrs[i].visible = false

func set_panel(value:bool) -> void:
	panel = value
	var ped = get_node_or_null("Spatial/panel")
	if ped:
		ped.visible = panel

func get_panel() -> bool:
	return panel

func set_grille(value:bool) -> void:
	grille = value
	var ped = get_node_or_null("Spatial/grille")
	if ped:
		ped.visible = grille

func get_grille() -> bool:
	return grille

func set_cylinder(value:bool) -> void:
	cylinder = value
	var ped = get_node_or_null("Spatial/Pedestal/pedestal")
	var cyl = get_node_or_null("Spatial/cylinder/cylinder")
	if (ped and cyl):
		ped.visible = !cylinder
		cyl.visible = cylinder
	change_gusset()

func get_cylinder() -> bool:
	return cylinder

func set_gussets(value: bool) -> void:
	gussets = value
	var _ped = get_node_or_null("Spatial/Pedestal/pedestal")
	var _cyl = get_node_or_null("Spatial/cylinder/cylinder")
	change_gusset()

func get_gussets() -> bool:
	return gussets

func set_pedestal_width(value: int) -> void:
	pedestal_width = value
	edit_ped()
	edit_par()

func get_pedestal_width() -> int:
	return pedestal_width

func set_pedestal_height(value: int) -> void:
	if grille_yaxis_movement >= pedestal_height - 50:
		set_grille_yaxis_movement(pedestal_height - 51)
		_editor_changed()
	if panel_yaxis_movement >= pedestal_height - 31:
		set_panel_yaxis_movement(pedestal_height - 31)
		_editor_changed()
	pedestal_height = value
	edit_ped()
	edit_par()

func get_pedestal_height() -> int:
	return pedestal_height

func set_faceplate_width(value: int) -> void:
	faceplate_width = value
	edit_faceplate_width(faceplate_width)

func get_faceplate_width() -> int:
	return faceplate_width

func set_faceplate_radius(value: int) -> void:
	faceplate_radius = value
	edit_faceplate_radius(faceplate_radius)

func get_faceplate_radius() -> int:
	return faceplate_radius

func set_support_width(value: int) -> void:
	support_width = value
	edit_support_width(support_width)

func get_support_width() -> int:
	return support_width

func set_support_size(value: int) -> void:
	if value <= pedestal_width + 100:
		value += 100
	support_size = value
	edit_support_size(support_size)

func get_support_size() -> int:
	return support_size

func edit_ped() -> void:
	var ped = get_node_or_null("Spatial/Pedestal/pedestal")
	var cyl = get_node_or_null("Spatial/cylinder/cylinder")
	var face = get_node_or_null("Spatial/RcsJoint/faceplate")
	var cube = get_node_or_null("Spatial/RcsJoint/Supportcubus/supportcubus")
	var panel = get_node_or_null("Spatial/panel")
	var grille = get_node_or_null("Spatial/grille")
	if grille_yaxis_movement >= pedestal_height - 50:
		set_grille_yaxis_movement(pedestal_height - 51)
		_editor_changed()
	if panel_yaxis_movement >= pedestal_height - 31:
		set_panel_yaxis_movement(pedestal_height - 31)
		_editor_changed()
	if (ped and cyl and cube and face and panel and grille):
		last_change_timestamp = OS.get_system_time_msecs()
		changed = true
		ped.translation = Vector3(0,support_width + pedestal_height / 2.0, 0)
		ped.scale  = Vector3(pedestal_width, pedestal_height, pedestal_width)
		
		panel.translation = Vector3(0.5 * pedestal_width - 1,panel_yaxis_movement + support_width,0)
		grille.translation = Vector3(-0.5 * pedestal_width + 23,grille_yaxis_movement + support_width,0)
		
		cube.scale.y = pedestal_height
		cube.translation = Vector3(0,support_width + 4 + pedestal_height / 2.0, 0)
		
		face.translation = Vector3(0,support_width + 1 + pedestal_height + faceplate_width / 1.2, 0)
		
		cyl.translation = Vector3(0, support_width + pedestal_height / 2.0, 0)    
		cyl.scale.x = pedestal_width / 2.0
		cyl.scale.z = pedestal_width / 2.0
		cyl.scale.y = pedestal_height
		if pedestal_width > support_size:
			support_size = pedestal_width

func edit_par() -> void:
	var cyl = get_node_or_null("Spatial/cylinder/cylinder")
	var meshin1 = get_node_or_null("Spatial/cylgusset/MeshInstance")
	var meshin2 = get_node_or_null("Spatial/cylgusset/MeshInstance2")
	var meshin3 = get_node_or_null("Spatial/cylgusset/MeshInstance3")
	var meshin4 = get_node_or_null("Spatial/cylgusset/MeshInstance4")
	var meshin5 = get_node_or_null("Spatial/cylgusset/MeshInstance5")
	var meshin6 = get_node_or_null("Spatial/cylgusset/MeshInstance6")
	if grille_yaxis_movement >= pedestal_height - 50:
		set_grille_yaxis_movement(pedestal_height - 51)
		_editor_changed()
	if panel_yaxis_movement >= pedestal_height - 31:
		set_panel_yaxis_movement(pedestal_height - 31)
		_editor_changed()
	if (meshin1 and meshin2 and meshin3 and meshin4 and meshin5 and meshin6):
		last_change_timestamp = OS.get_system_time_msecs()
		changed = true
		meshin1.translation.x = 0 - cyl.scale.x / sqrt(1.7)
		meshin1.translation.z = 0 - cyl.scale.x / sqrt(1.7)
		meshin1.scale  = Vector3(60, pedestal_height, 7)
		meshin1.translation.y = support_width + pedestal_height / 2.0
		
		meshin2.translation.x = 0 - cyl.scale.x / sqrt(1.7)
		meshin2.translation.z = cyl.scale.x / sqrt(1.7)
		meshin2.scale  = Vector3(60, pedestal_height, 7)
		meshin2.translation.y = support_width + pedestal_height / 2.0
		
		meshin6.translation.x = cyl.scale.x / sqrt(1.7)
		meshin6.translation.z = cyl.scale.x / sqrt(1.7)
		meshin6.scale  = Vector3(60, pedestal_height, 7)
		meshin6.translation.y = support_width + pedestal_height / 2.0
		
		meshin5.translation.x = cyl.scale.x / sqrt(1.7)
		meshin5.translation.z = 0 - cyl.scale.x / sqrt(1.7)
		meshin5.scale  = Vector3(60, pedestal_height, 7)
		meshin5.translation.y = support_width + pedestal_height / 2.0
		
		meshin3.translation.z = cyl.scale.x + cyl.scale.x / 12.0
		meshin3.scale  = Vector3(60, pedestal_height, 7)
		meshin3.translation.y = support_width + pedestal_height / 2.0
		
		meshin4.translation.z = 0 - cyl.scale.x - cyl.scale.x / 12.0
		meshin4.scale  = Vector3(60, pedestal_height, 7)
		meshin4.translation.y = support_width + pedestal_height / 2.0
	var kosx1 = get_node_or_null("Spatial/gusset/xkos1/MeshInstance")
	if kosx1:
		kosx1.translation.y = support_width + pedestal_height / 2.0
		kosx1.translation.x = (pedestal_width / 2.0) + 20
		kosx1.translation.z = (pedestal_width / 3.0)
		kosx1.scale  = Vector3(60,pedestal_height,10)
	var kosx2 = get_node_or_null("Spatial/gusset/xkos1/MeshInstance2")
	if kosx2:
		kosx2.translation.y = support_width + pedestal_height / 2.0
		kosx2.translation.x = (pedestal_width / 2.0) + 20
		kosx2.translation.z = (pedestal_width / 3.0) - (pedestal_width / 1.5)
		kosx2.scale  = Vector3(60,pedestal_height,10)
	var kosx11 = get_node_or_null("Spatial/gusset/xkos2/MeshInstance")
	if kosx11:
		kosx11.translation.y = support_width + pedestal_height / 2.0
		kosx11.translation.x = 0 - (pedestal_width / 2.0) - 20
		kosx11.translation.z = (pedestal_width / 3.0)
		kosx11.scale  = Vector3(60,pedestal_height,10)
	var kosx22 = get_node_or_null("Spatial/gusset/xkos2/MeshInstance2")
	if kosx22:
		kosx22.translation.y = support_width + pedestal_height / 2.0
		kosx22.translation.x = 0 - (pedestal_width / 2.0) - 20
		kosx22.translation.z = (pedestal_width / 3.0) - (pedestal_width / 1.5)
		kosx22.scale  = Vector3(60,pedestal_height,10)
	var kosx3 = get_node_or_null("Spatial/gusset/zkos1/MeshInstance")
	if kosx3:
		kosx3.translation.y = support_width + pedestal_height / 2.0
		kosx3.translation.z = (pedestal_width / 2.0) + 20
		kosx3.translation.x = (pedestal_width / 3.0) - (pedestal_width / 1.5)
		kosx3.scale  = Vector3(60,pedestal_height,10)
	var kosx4 = get_node_or_null("Spatial/gusset/zkos1/MeshInstance2")
	if kosx4:
		kosx4.translation.y = support_width + pedestal_height / 2.0
		kosx4.translation.z = (pedestal_width / 2.0) + 20
		kosx4.translation.x = (pedestal_width / 3.0)
		kosx4.scale  = Vector3(60,pedestal_height,10)
	var kosx31 = get_node_or_null("Spatial/gusset/zkos2/MeshInstance")
	if kosx31:
		kosx31.translation.y = support_width + pedestal_height / 2.0
		kosx31.translation.z = 0 - (pedestal_width / 2) - 20
		kosx31.translation.x = (pedestal_width / 3.0)
		kosx31.scale  = Vector3(60,pedestal_height,10)
	var kosx41 = get_node_or_null("Spatial/gusset/zkos2/MeshInstance2")
	if kosx41:
		kosx41.translation.y = support_width + pedestal_height / 2.0
		kosx41.translation.z = 0 - (pedestal_width / 2) - 20
		kosx41.translation.x = (pedestal_width / 3.0) - (pedestal_width / 1.5)
		kosx41.scale  = Vector3(60,pedestal_height,10)
	edit_support_size(support_size)

func edition():
	edit_par()
	edit_ped()

func edit_support_width(support_width):
	var sup = get_node_or_null("Spatial/support/support")
	if sup:
		sup.translation = Vector3(0,support_width / 2 + 1,0)
		sup.scale  = Vector3(support_size,support_width,support_size)
	var left_pole = get_node_or_null("Spatial/Pedestal/pedestal")
	if left_pole:
		left_pole.translation = Vector3(0,support_width + pedestal_height / 2.0, 0)
		left_pole.scale  = Vector3(pedestal_width,pedestal_height,pedestal_width)
	var face = get_node_or_null("Spatial/RcsJoint/faceplate")
	if face:
		face.translation = Vector3(0,support_width + 2 + pedestal_height + faceplate_width / 1.2, 0)
	var cube = get_node_or_null("Spatial/RcsJoint/Supportcubus/supportcubus")
	if cube:
		cube.scale.y = pedestal_height
		cube.translation = Vector3(0,support_width + 4 + pedestal_height / 2.0, 0)
	var cylind = get_node_or_null("Spatial/cylinder/cylinder")
	if cylind:
		cylind.translation.y = support_width + pedestal_height / 2
		cylind.scale.x = pedestal_width / 2.0
		cylind.scale.z = pedestal_width / 2.0
		cylind.scale.y = pedestal_height
	var grille = get_node_or_null("Spatial/grille")
	if grille:
		grille.translation.y = support_width + grille_yaxis_movement
	var panel = get_node_or_null("Spatial/panel")
	if panel:
		panel.translation.y = support_width + panel_yaxis_movement
	var meshin1 = get_node_or_null("Spatial/cylgusset/MeshInstance")
	var meshin2 = get_node_or_null("Spatial/cylgusset/MeshInstance2")
	var meshin3 = get_node_or_null("Spatial/cylgusset/MeshInstance3")
	var meshin4 = get_node_or_null("Spatial/cylgusset/MeshInstance4")
	var meshin5 = get_node_or_null("Spatial/cylgusset/MeshInstance5")
	var meshin6 = get_node_or_null("Spatial/cylgusset/MeshInstance6")
	var arrs = [meshin1, meshin2, meshin3, meshin4, meshin5, meshin6]
	if arrs:
		for i in range(0,len(arrs)):
			arrs[i].translation.y = support_width + pedestal_height / 2.0
	var kosx1 = get_node_or_null("Spatial/gusset/xkos1/MeshInstance")
	var kosx2 = get_node_or_null("Spatial/gusset/xkos1/MeshInstance2")
	var kosx11 = get_node_or_null("Spatial/gusset/xkos2/MeshInstance")
	var kosx22 = get_node_or_null("Spatial/gusset/xkos2/MeshInstance2")
	var kosx3 = get_node_or_null("Spatial/gusset/zkos1/MeshInstance")
	var kosx4 = get_node_or_null("Spatial/gusset/zkos1/MeshInstance2")
	var kosx31 = get_node_or_null("Spatial/gusset/zkos2/MeshInstance")
	var kosx41 = get_node_or_null("Spatial/gusset/zkos2/MeshInstance2")
	var arr = [kosx1, kosx2, kosx11, kosx22,kosx3, kosx4, kosx31, kosx41]
	if arr:
		for i in range(0,len(arr)):
			arr[i].translation.y = support_width + pedestal_height / 2.0

func edit_support_size(support_size):
	var sup = get_node_or_null("Spatial/support/support")
	if sup:
		last_change_timestamp = OS.get_system_time_msecs()
		changed = true
		sup.scale  = Vector3(support_size,support_width,support_size)
		if support_size < pedestal_width:
			pedestal_width = support_size
			edition()

func edit_faceplate_radius(faceplate_radius):
	var face = get_node_or_null("Spatial/RcsJoint/faceplate")
	if face:
		face.scale = Vector3(faceplate_radius / 50.0, faceplate_width / 2.0, faceplate_radius / 50.0)
		face.translation = Vector3(0,support_width + 2 + pedestal_height + faceplate_width / 1.3, 0)
	var cubes = get_node_or_null("Spatial/RcsJoint/Supportcubus/supportcubus")
	if cubes:
		cubes.scale.x = (faceplate_radius / 5) + (faceplate_width / 3)
		cubes.scale.z = (faceplate_radius / 5) + (faceplate_width / 3)

func edit_faceplate_width(faceplate_width):
	var facew = get_node_or_null("Spatial/RcsJoint/faceplate")
	var cube = get_node_or_null("Spatial/RcsJoint/Supportcubus/supportcubus")
	var sup = get_node_or_null("Spatial/support/support")
	if cube:
		cube.scale.x = (faceplate_radius / 5.0) + (faceplate_width / 3.0)
		cube.scale.z = (faceplate_radius / 5.0) + (faceplate_width / 3.0)
		cube.translation = Vector3(0,support_width + 4 + pedestal_height / 2.0, 0)
	if facew:
		facew.scale = Vector3(faceplate_radius / 50.0, faceplate_width / 2.0, faceplate_radius / 50.0)
		facew.translation = Vector3(0,support_width + 2 + pedestal_height + faceplate_width / 1.3, 0)

func _ready():
	spatial = get_spatial()
	changed = false

func _process(delta):
	if (changed and (OS.get_system_time_msecs() - last_change_timestamp > 500)):
		property_list_changed_notify()
		changed = false;


func _editor_changed():
	var _run = true
	yield(get_tree().create_timer(0.5), "timeout")
	if _run == true:
		property_list_changed_notify()
		_run = false
