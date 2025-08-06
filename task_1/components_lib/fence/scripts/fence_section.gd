tool
extends Spatial

#class_name Fence_section_true

export(int) var section_height = 2060 setget set_sh
export(int) var section_width = 1420 setget set_sw
export(int) var floor_gap = 85 setget set_fg

func _ready():
	pass

#------>POLES<--------------
func get_both_poles():
	return $Poles
func get_pole1():
	return $Poles/Pole1
func get_pole2():
	return $Poles/Pole2
#------>BARBELLS<--------------
func get_both_barbells():
	return $Barbells
func get_barbell_right(): 
	return $Barbells/barbell_right 
func get_barbell_left(): 
	return $Barbells/barbell_left 
#------>CROSSBARS<--------------
func get_crossbar(): 
	return $Crossbars
func get_crossbar_upper():
	return $Crossbars/crossbar_upper
func get_crossbar_lower():
	return $Crossbars/crossbar_lower
#------>PLANKS<--------------
func get_planks():
	return $Crossbars/Planks
func get_plank_front():
	return $Crossbars/Planks/plank_front
func get_plank_back():
	return $Crossbars/Planks/plank_back
#------>HINGES<--------------
func get_upper_left_hinge():
	return $Upper_left_hinge
func get_upper_right_hinge():
	return $Upper_right_hinge
func get_lower_left_hinge():
	return $Lower_left_hinge
func get_lower_right_hinge():
	return $Lower_right_hinge
#------>GRID<--------------
func get_grid():
	return $Grid/grid
#------->NEEDED FUNCTIONS<------------------

func move_planks():
	var moving_planks = get_planks()
	moving_planks.translation.y=(section_height - 25 - floor_gap)/2.0 + floor_gap - 85

func edit_barbells():
	var edited_barbells = get_both_barbells()
	edited_barbells.scale.y = (section_height - 25 - floor_gap)/1950.0
	edited_barbells.translation.y = (section_height - 25 - floor_gap)/2.0 + floor_gap 
	#barbell_right.scale.y = (section_height - 25 - floor_gap)/1950.0 #+ floor_gap
	#barbell_left.scale.y = (section_height - 25 - floor_gap)/1950.0 #+ floor_gap

func edit_grid() -> void:
	var grid = get_grid()
	if grid:
		grid.translation.z = (section_width - 170)/2.0 + 90 #1262.5 - 0.5 * section_width
		grid.translation.y = ((section_height-55) - (floor_gap+30))/2.0 + floor_gap + 30 #0.5 * (section_height + floor_gap) - 1050.5
		grid.scale = Vector3(((section_height-55) - (floor_gap+30))/1890.0, 1, (section_width - 170)/1250.0)
		var grid_material = grid.get_surface_material(0)
		if grid_material:
			grid_material.uv1_scale = Vector3(((section_height-55) - (floor_gap+30))/1890.0, (section_width - 170)/1250.0, 1)

#-------->SETTERS<-----------------------------------------------

func set_sh(height):
	#--------------->poles<--------------------------------------
	var poles = get_both_poles()
	poles.scale.y = height/2060.0
	#------------>crossbar_upper<--------------------------------
	var height_crossbar_upper = height - 125
	var crossbar_upper = get_crossbar_upper()
	crossbar_upper.translation.y = height_crossbar_upper	
	#---------------->hinges<---------------------------------
	var up_hinge_left = get_upper_left_hinge()
	var up_hinge_right = get_upper_right_hinge()
	up_hinge_left.translation.y = height - 175
	up_hinge_right.translation.y = height - 175
	#---------------->output<--------------------------------
	section_height=height
	#---------------->funcs<------------------------------
	move_planks()
	edit_barbells()
	edit_grid()
	
func set_sw(width):
	#---------------->pole2<------------------------------------
	var pole2 = get_pole2()
	pole2.translation.z = width
	#------------->barbell_right<------------------------------------
	var width_barbell_right = width - 130
	var barbell_right = get_barbell_right()
	barbell_right.translation.z = width_barbell_right
	#--------------->crossbars<-------------------------------------
	var width_crossbars = width-120
	var crossbars = get_crossbar()
	crossbars.scale.z = width_crossbars/1300.0
	#---------------->hinges<--------------------------------------
	var up_right_hinge = get_upper_right_hinge()
	var low_right_hinge = get_lower_right_hinge()
	up_right_hinge.translation.z = width
	low_right_hinge.translation.z = width
	#----------------->output<-------------------------------------
	section_width = width
	#---------------->funcs<------------------------------
	edit_grid()

func set_fg(gap):
	#---------------->crossbar<-------------------------------------
	var crossbar_lower = get_crossbar_lower()
	crossbar_lower.translation.y = gap - 70
	#---------------->hinges<--------------------------------------
	var low_hinge_left = get_lower_left_hinge()
	var low_hinge_right = get_lower_right_hinge()
	low_hinge_left.translation.y = gap + 100
	low_hinge_right.translation.y = gap + 100
	#----------------->output<-----------------------------------
	floor_gap = gap
	#---------------->funcs<------------------------------------
	move_planks()
	edit_barbells()
	edit_grid()
