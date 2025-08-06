tool
extends Spatial

export(int,325,5000,1) var section_width = 1500 setget set_sw
export(int,460,10000,1) var section_height = 2060 setget set_sh
export(int,10,10000,1) var floor_gap = 85 setget set_fg
export(int,325,100000,1) var fence_length = 7500 setget set_fl
export(int,1,50,1) var number_of_sections = 5 setget set_nos
enum T {Base_section_width,Editable_section_width}
export(T) var width_edit_mode = T.Base_section_width setget set_wem
export(int,325,5000,1) var standard_section_width = 1500 setget set_ssw

var scene_to_instance = "res://components_lib/fence/fence_section/fence_section.tscn"
var parts_group = "fence"
var shift_to_first : Vector3
var generator = get_generator()
var scene_instance
var changed: bool
var last_change_timestamp : int
var ssw_changed : bool
var wem_changed : bool

var inited = false

func _addNode(scene : Node, container : Node, child : Node):
	container.add_child(child)
	child.set_owner(scene)

func _generateScene() -> Node:
	var scene = scene_instance.instance()	
	scene.name = parts_group + "_1"
	if (parts_group.length() > 0):
		scene.add_to_group(parts_group, true)
	return scene

func get_generator():
	return $"."

#------------------------------>GENERATE<--------------------------------------------------------------
func _generateScenes(containerName : String):
	var root = get_node_or_null(".") #get_tree().get_edited_scene_root()
	if(root == null):
		printerr("Scene was null.")
		return
	
	var container = root.get_node(containerName)
	if(container == null):
		printerr("Container %s not found." % containerName)
		return
	
	scene_instance = load(scene_to_instance)
	
	for j in range (number_of_sections):
		var scene = _generateScene() 
		scene.section_height = section_height
		scene.section_width = fence_length/number_of_sections
		var row_step = Vector3(0,0,scene.section_width)
		scene.floor_gap = floor_gap
		scene.transform.origin = shift_to_first + row_step*j
		_addNode(root, container, scene)

func _clearAllGeneratedScenes():
	print("_clearAllGeneratedScenes")
	if (parts_group.length() > 0):
		var scenes = generator.get_children() #get_tree().get_nodes_in_group(parts_group)
		if (len(scenes) == 0):
			print("Delete generated scenes was break. Not found generated scenes.")
			return
		
		for scene in scenes:
			generator.remove_child(scene)
#------------------------------------><----------------------------------------------------------

#----------------------------->SETTERS<----------------------------------------------------------
func set_fl(length):
	fence_length = length
	if inited:
		last_change_timestamp = OS.get_system_time_msecs()
		changed = true
		if width_edit_mode == 0:
			if (length%standard_section_width) <= (standard_section_width/2):
				if length/standard_section_width == 0:
					number_of_sections = 1
				else:
					number_of_sections = length/standard_section_width
			else:
				number_of_sections = (length / standard_section_width)+1
		_clearAllGeneratedScenes()
		_generateScenes(self.get_path())
		var scenes = generator.get_children()
		scenes.sort()
		for scene in scenes:
			var a = scenes.bsearch(scene) as int
			section_width = length/number_of_sections
			scene.section_width = section_width
			scene.translation.z = 0+section_width*a
			fence_length = length

func set_wem(token):
	width_edit_mode = token
	if inited:
		width_edit_mode = token
		wem_changed = true
		if wem_changed == true and token == 0:
			set_fl(standard_section_width*number_of_sections)
			wem_changed = false
		elif wem_changed == true and token == 1:
			wem_changed = false

func set_ssw(ssw):
	standard_section_width = ssw
	if inited:
		last_change_timestamp = OS.get_system_time_msecs()
		changed = true
		if width_edit_mode == 0:
			set_fl(ssw*number_of_sections)

func set_nos(number):
	number_of_sections = number
	if inited:
		last_change_timestamp = OS.get_system_time_msecs()
		changed = true
		fence_length = section_width*number
		number_of_sections=number as int
		_clearAllGeneratedScenes()
		_generateScenes(self.get_path())

func set_sh(height):
	section_height = height
	if inited:
		section_height = height
		var scenes = generator.get_children()
		if section_height > (floor_gap+450):
			for scene in scenes:
				scene.section_height = height
		else: 
			section_height = floor_gap+450
			for scene in scenes:
				scene.section_height = section_height

func set_sw(width):
	if inited == false:
		section_width = width
	elif inited:
		last_change_timestamp = OS.get_system_time_msecs()
		changed = true
		if width_edit_mode == 1:
			section_width = width
			fence_length = width*number_of_sections
			var scenes = generator.get_children()
			scenes.sort()
			for scene in scenes:
				var a = scenes.bsearch(scene) as int
				scene.section_width = width
				scene.translation.z = 0+width*a

func set_fg(gap):
	floor_gap = gap
	if inited:
		floor_gap = gap
		var scenes = generator.get_children()
		if floor_gap <= (section_height-450): #and floor_gap >= 5:
			for scene in scenes:
				scene.floor_gap = gap
#		elif floor_gap < 5:
#			floor_gap = 5
#			for scene in scenes:
#				scene.floor_gap = 5
		else:#elif floor_gap > (section_height-450):
			floor_gap = section_height-450
			for scene in scenes:
				scene.floor_gap = floor_gap

# Called when the node enters the scene tree for the first time.
func _ready():
	if generator.get_children() == []:
		_generateScenes(self.get_path())
	changed = false
	inited = true
	set_fl(fence_length)
#	set_wem(width_edit_mode)
#	set_ssw(standard_section_width)
	set_nos(number_of_sections)
	set_sh(section_height)
	set_sw(section_width)
	set_fg(floor_gap)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (changed and (OS.get_system_time_msecs() - last_change_timestamp > 500)):
		property_list_changed_notify()
		changed = false
