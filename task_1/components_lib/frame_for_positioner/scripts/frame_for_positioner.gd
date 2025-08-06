tool
extends Spatial

class_name rotate_H_positioner

export (float, 500, 4500) var Lenght_Of_Table_mm = 1800 setget set_len_table
export (float, 500, 1500) var Width_Of_Table_mm = 800 setget set_width_table
export (float, 90, 130) var Width_Of_Frame_mm = 90 setget set_width_frame
export (float, 90, 160) var Height_Of_Frame_mm = 90 setget set_height_frame
export (float, 100, 545) var Diameter_Of_Kronshtein_mm = 400 setget set_diameter_kron
export (float, 0, 300) var Height_Of_Kronshtein_mm = 150 setget set_height_table
export (bool) var rotate_frame =  false setget set_rotate_frame, get_rotate_frame



#поворот стола 
func set_rotate_frame(state: bool) -> void:
	rotate_frame = state
	var rotate = get_node_or_null("frame_for_positioner/rotate/rotate")
	if rotate:
		rotate.TogglePositive = rotate_frame

func get_rotate_frame()-> bool:
	return rotate_frame

# функция регулирования длины стола
func set_len_table(value):
	Lenght_Of_Table_mm = value
	var stick_x1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_x") as MeshInstance
	var stick_x2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-x") as MeshInstance
	var stick_y1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_y") as MeshInstance
	var stick_y2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-y") as MeshInstance
	var kron_1 = get_node_or_null("./frame_for_positioner/kronshtein_cylinder_y") as MeshInstance
	
	if stick_x1:
		stick_x1.scale.z = Lenght_Of_Table_mm/1800
		stick_x1.translation.z = (Lenght_Of_Table_mm/1800 - 1)*900

		stick_x2.scale.z = Lenght_Of_Table_mm/1800
		stick_x2.translation.z = (Lenght_Of_Table_mm/1800 - 1)*900

		stick_y1.translation.z = Lenght_Of_Table_mm - 945 - (Width_Of_Frame_mm/2 - 45)

		kron_1.translation.z = Lenght_Of_Table_mm - 945 + 50

# функция регулирования ширины стола
func set_width_table(value):
	Width_Of_Table_mm = value
	var stick_y1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_y") as MeshInstance
	var stick_y2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-y") as MeshInstance
	var stick_x1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_x") as MeshInstance
	var stick_x2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-x") as MeshInstance
	if stick_y1:
		stick_y1.scale.x = Width_Of_Table_mm/800

		stick_y2.scale.x = Width_Of_Table_mm/800

		stick_x1.translation.x = Width_Of_Table_mm/2 - 45 - (Width_Of_Frame_mm/2 - 45)

		stick_x2.translation.x = - Width_Of_Table_mm/2 + 45 + (Width_Of_Frame_mm/2 - 45)

# функция ширины рамы (по x и z)
func set_width_frame(value):
	Width_Of_Frame_mm = value
	var stick_y1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_y") as MeshInstance
	var stick_y2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-y") as MeshInstance
	var stick_x1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_x") as MeshInstance
	var stick_x2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-x") as MeshInstance
	if stick_x1:
		stick_x1.scale.x = Width_Of_Frame_mm/90
		stick_x1.translation.x = Width_Of_Table_mm/2 - 45 - (Width_Of_Frame_mm/2 - 45)
		
		stick_x2.scale.x = Width_Of_Frame_mm/90
		stick_x2.translation.x = - Width_Of_Table_mm/2 + 45 + (Width_Of_Frame_mm/2 - 45)
		
		stick_y1.scale.z = Width_Of_Frame_mm/90
		stick_y1.translation.z = Lenght_Of_Table_mm - 945 - (Width_Of_Frame_mm/2 - 45)

		stick_y2.scale.z = Width_Of_Frame_mm/90
		stick_y2.translation.z = - 855 + (Width_Of_Frame_mm/2 - 45)

# функция регулирования высоты рамы (расширение по y)
func set_height_frame(value):
	Height_Of_Frame_mm = value
	var stick_y1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_y") as MeshInstance
	var stick_y2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-y") as MeshInstance
	var stick_x1 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_x") as MeshInstance
	var stick_x2 = get_node_or_null("./frame_for_positioner/rotate/rotate/stick/stick_-x") as MeshInstance
	if stick_x1:
		stick_x1.scale.y = Height_Of_Frame_mm/90

		stick_x2.scale.y = Height_Of_Frame_mm/90

		stick_y1.scale.y = Height_Of_Frame_mm/90

		stick_y2.scale.y = Height_Of_Frame_mm/90

# фунция регулирования диаметра кронштейна
func set_diameter_kron(value):
	Diameter_Of_Kronshtein_mm = value
	var kron_1 = get_node_or_null("./frame_for_positioner/kronshtein_cylinder_y") as MeshInstance
	var kron_2 = get_node_or_null("./frame_for_positioner/kronshtein_cylinder_-y") as MeshInstance
	if kron_1:
		kron_1.scale.y = Diameter_Of_Kronshtein_mm/400
		kron_1.scale.x = Diameter_Of_Kronshtein_mm/400
		kron_2.scale.y = Diameter_Of_Kronshtein_mm/400
		kron_2.scale.x = Diameter_Of_Kronshtein_mm/400

# фунция регулирования высоты стола
func set_height_table(value):
	Height_Of_Kronshtein_mm = value
	var kron_1 = get_node_or_null("./frame_for_positioner/kronshtein_cylinder_y") as MeshInstance
	var kron_2 = get_node_or_null("./frame_for_positioner/kronshtein_cylinder_-y") as MeshInstance
	if kron_1:
		kron_1.translation.y = Height_Of_Kronshtein_mm - Diameter_Of_Kronshtein_mm/2 + 200
		kron_2.translation.y = Height_Of_Kronshtein_mm - Diameter_Of_Kronshtein_mm/2 + 200
	
