tool
extends RcsConveyor

export(float, 300.0, 5000.0, 0.1) var height_conveyor_MM = 711 setget set_height_conveyor
export(float, 200.0, 2500.0, 0.1) var width_conveyor_MM = 410 setget set_width_conveyor
export(float, 500.0, 7000.0, 0.1) var length_conveyor_MM = 1500  setget set_length_conveyor
export(float, 4.0, 30.0, 2.0) var number_of_leg = 4 setget set_legs_count #set_number_of_leg 
export(String, "On the left and right", "On the left", "On the right", "None") var board = "On the left and right" setget set_board_visible#, get_board_right_false, get_board_left_false
export(float, 50.0, 1000.0, 0.1) var height_board_MM = 100 setget set_height_board
#export(float, 50.0, 1000.0, 0.1) var height_board_left_MM = 100 setget set_height_board_left
export(String, "On the left and right", "On the left", "On the right", "None") var engine = "On the left and right" setget set_engine_visible
export(String, "At the beginning and end of the conveyor", "At the beginning of the conveyor belt", "At the end of the conveyor", "None") var availability_of_the_knife = "None" setget set_knife_visible
export(int) var height_Collision_conveyor_MM = 20 setget set_Collision_conveyor
var row_step_legs = 526.5 setget set_legs_row

var last_toggle : bool
var changed: bool
var last_change_timestamp:int
var loaded = false

var time_passed = 0


#
func conveyor1():
#height_board
	$Conveyor/Board/Board_left/board_left.scale.y =height_board_MM /100
	$Conveyor/Board/Board_right/board_right.scale.y =height_board_MM /100

#Collision_conveyor
	$Collision_conveyor.scale.y = height_Collision_conveyor_MM
	$Collision_conveyor.translation.y = height_conveyor_MM + 28 + $Collision_conveyor.scale.y 

func get_conveyor ():
	return $Conveyor/conveyor

func get_engine ():
	return $Conveyor/Engine

func get_right_engine ():
	return $Conveyor/Engine/engine_right

func get_left_engine ():
	return $Conveyor/Engine/engine_left

func get_board ():
	return $Conveyor/Board

func get_right_board ():
	return $Conveyor/Board/Board_right

func get_left_board ():
	return $Conveyor/Board/Board_left
	
	
func get_collision_conveyor():
	return $Collision_conveyor


#height_conveyor 
func set_height_conveyor (height):
	if (length_conveyor_MM == height):
		return	
	height_conveyor_MM = height
	if (!loaded):
		return;
	var height_conveyor = get_conveyor()
	var height_engine = get_engine()
	var height_board = get_board()
#	var height_static_bode = get_static_bode()
	var height_collision_conveyor = get_collision_conveyor()

	if height_conveyor:
		height_conveyor.translation.y = height
		height_engine.translation.y = height
		height_board.translation.y = height
		height_collision_conveyor.translation.y = height+45.0
		set_legs_count(number_of_leg)
#	rebuild_conveyor_size()

#width_conveyor 
func set_width_conveyor (width):
	if (length_conveyor_MM == width):
		return	
	width_conveyor_MM = width
	if (!loaded):
		return;
	var width_conveyor = get_conveyor()
	var width_right_engine = get_right_engine()
	var width_left_engine = get_left_engine()
	var width_board_right = get_right_board()
	var width_board_left = get_left_board() 
	var width_collision_conveyor = get_collision_conveyor()

	width_conveyor.scale.z = width  /400.0
	width_right_engine.translation.z = - width /1.9 -8.0
	width_left_engine.translation.z =  width /1.9 +28
	width_board_right.translation.z =  -width /2.1
	width_board_left.translation.z =  width /2.0
	width_collision_conveyor.scale.z = width
	set_legs_count(number_of_leg)
	#rebuild_conveyor_size()

#length_conveyor 
func set_length_conveyor (length):
#	if (length_conveyor_MM == length):
#		return	
	length_conveyor_MM =length
	if (!loaded):
		return;
	var length_conveyor = get_conveyor()
	var length_board_right = get_right_board()
	var length_board_left = get_left_board() 
	var length_collision_conveyor = get_collision_conveyor()
	
	length_conveyor.scale.x =length /1053.0
	length_conveyor.translation.x =length/2.0
	length_board_right.scale.x =length /1053.0
	length_board_right.translation.x = (length/1053)*0.01
	length_board_left.scale.x =length /1053.0
	length_collision_conveyor.scale.x=length 
	length_collision_conveyor.translation.x=length /2.0
	set_legs_count(number_of_leg)
	conveyor1()
	
#	rebuild_conveyor_size()

#height_board 
func set_height_board (value):
#	if (height_board_MM == value):
#		return	
	height_board_MM = value
	if (!loaded):
		return;
	var height_board_r = get_right_board()
	var height_board_l = get_left_board ()
	height_board_r.translation.y = height_board_MM/2
	height_board_l.translation.y = height_board_MM/2
	conveyor1()
	

#engine visible
func set_engine_visible(value):
	engine = value
	var engine_right = get_node_or_null("./Conveyor/Engine/engine_right") as MeshInstance
	var engine_left = get_node_or_null("./Conveyor/Engine/engine_left") as MeshInstance

	if  engine == "On the left and right":
		if engine_right and engine_left:
			engine_left.visible = true
			engine_right.visible = true
	if engine == "On the left":
		if engine_right and engine_left:
			engine_left.visible = true
			engine_right.visible = false
	if engine == "On the right":
		if engine_right and engine_left:
			engine_left.visible = false
			engine_right.visible = true
	if engine == "None":
		if engine_right and engine_left:
			engine_left.visible = false
			engine_right.visible = false

#board visible
func set_board_visible(value):
	board = value
	var board_right = get_node_or_null("./Conveyor/Board/Board_right") as MeshInstance
	var board_left = get_node_or_null("./Conveyor/Board/Board_left") as MeshInstance

	if  board == "On the left and right":
		if board_right and board_left:
			board_left.visible = true
			board_right.visible = true
	if board == "On the left":
		if board_right and board_left:
			board_left.visible = true
			board_right.visible = false
	if board == "On the right":
		if board_right and board_left:
			board_left.visible = false
			board_right.visible = true
	if board == "None":
		if board_right and board_left:
			board_left.visible = false
			board_right.visible = false

#Видимость ножа 
func set_knife_visible(value):
	availability_of_the_knife = value
	var knife_transition_1 = get_node_or_null("./Conveyor/conveyor/knife_transition_1") as MeshInstance
	var knife_transition_2 = get_node_or_null("./Conveyor/conveyor/knife_transition_2") as MeshInstance
	
	if  availability_of_the_knife == "At the beginning and end of the conveyor":
		if knife_transition_2 and knife_transition_1:
			knife_transition_1.visible = true
			knife_transition_2.visible = true
	if availability_of_the_knife == "At the beginning of the conveyor belt":
		if knife_transition_2 and knife_transition_1:
			knife_transition_1.visible = true
			knife_transition_2.visible = false
	if availability_of_the_knife == "At the end of the conveyor":
		if knife_transition_2 and knife_transition_1:
			knife_transition_1.visible = false
			knife_transition_2.visible = true
	if availability_of_the_knife == "None":
		if knife_transition_2 and knife_transition_1:
			knife_transition_1.visible = false
			knife_transition_2.visible = false

#height_Collision_conveyor_MM
func set_Collision_conveyor(value):
	if (height_Collision_conveyor_MM == value):
		return	
	height_Collision_conveyor_MM = value
	if (!loaded):
		return;
	conveyor1()

func rebuild_conveyor_size():
	set_length_conveyor(length_conveyor_MM)
	set_width_conveyor(width_conveyor_MM)
	set_height_conveyor(height_conveyor_MM)
	set_height_board (height_board_MM)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#loaded = true
	if (OS.get_system_time_msecs() - time_passed > 800 and changed):
		property_list_changed_notify()
		changed = false
		time_passed = OS.get_system_time_msecs()

func rebuild_legs():
	print("rebuild_legs")
	time_passed = OS.get_system_time_msecs()
	changed = true
	
	var Legs_Generator_1 = get_node_or_null("Legs_Generator_1") as RcsGridPartGenerator
	var Legs_Generator_2 = get_node_or_null("Legs_Generator_2") as RcsGridPartGenerator
	if Legs_Generator_1:
		Legs_Generator_1.clear_parts()
		Legs_Generator_1.rebuild_parts()
	if Legs_Generator_2:
		Legs_Generator_2.clear_parts()
		Legs_Generator_2.rebuild_parts()

func set_legs_row(value):
	if (row_step_legs == value):
		return
	row_step_legs = value
	if (!loaded):
		return;
	var Legs_Generator_1 = get_node_or_null("Legs_Generator_1") as RcsGridPartGenerator
	var Legs_Generator_2 = get_node_or_null("Legs_Generator_2") as RcsGridPartGenerator
	var conveyor = get_node_or_null("Conveyor/conveyor") as MeshInstance
	var legs_side = number_of_leg/2

	if conveyor:
		var max_row_step = length_conveyor_MM/ (legs_side)
		if row_step_legs > max_row_step:
			 row_step_legs = max_row_step
		var row_step_offset = row_step_legs
		if Legs_Generator_1:
			Legs_Generator_1.row_step = Vector3(row_step_offset,0, 0)
			Legs_Generator_1.translation.x = ((legs_side - 1) * row_step_offset) / 2
		if Legs_Generator_2:
			Legs_Generator_2.row_step = Vector3(row_step_offset,0, 0)
			Legs_Generator_2.translation.x =  ((legs_side - 1) * row_step_offset) /2
		rebuild_legs()

func set_legs_count(value):
	var Legs_Generator_1 = get_node_or_null("Legs_Generator_1") as RcsGridPartGenerator
	var Legs_Generator_2 = get_node_or_null("Legs_Generator_2") as RcsGridPartGenerator
	number_of_leg = value
	print(loaded)
	if (!loaded):
		return;
	var legs_side = number_of_leg/2
	set_legs_row(calculate_row_step(legs_side))
		
	if Legs_Generator_1:
		Legs_Generator_1.row_step = Vector3(0.75*length_conveyor_MM/(legs_side-1),0,0)
		Legs_Generator_1.scale.y = height_conveyor_MM/711
		Legs_Generator_1.translation.x = length_conveyor_MM/6.0
		Legs_Generator_1.translation.z = - 1*width_conveyor_MM/2.0
		Legs_Generator_1.rows = legs_side
	rebuild_legs()
#
	if Legs_Generator_2:
		Legs_Generator_2.row_step = Vector3((0.75*length_conveyor_MM/(legs_side-1)),0,0)
		Legs_Generator_2.scale.y = height_conveyor_MM/711
		Legs_Generator_2.translation.x = length_conveyor_MM/6.0
		Legs_Generator_2.translation.z = 1*width_conveyor_MM/2.0
		Legs_Generator_2.rows = legs_side
	rebuild_legs()
	
func calculate_row_step(number_pare_of_leg):
	var calculated_row_step = (length_conveyor_MM/(number_pare_of_leg))
	return calculated_row_step


func _ready():
	loaded = true
	rebuild_legs() #
#	rebuild_lenght()
	rebuild_conveyor_size()
