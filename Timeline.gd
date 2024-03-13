extends Node2D




var a = 0
var v = 0.0

var editTarget

var speed = 70.0
var lastpos = Vector2(0,0)

var camerapos = Vector2(0,0)
var ogcampos = Vector2(0,0)

@onready var dateTree = $VBoxContainer/Dates

var DATE = preload("res://date.tscn")

func add_event():
	var left
	if(dateTree.get_child_count() > 0):
		left = not (dateTree.get_children()[-1].get_children()[-1].left)
	else:
		left = true
		
	var event = DATE.instantiate()
	var cont = HBoxContainer.new()
	cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	cont.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var sep = Container.new()
	cont.add_child(sep)
	if(left):
		sep.custom_minimum_size.x = 510
	
	event.timeroot = self
	
	event.left = left
	
	event.delete.connect(remove_event)
	
	cont.add_child(event)
	
	v = event.size.y / 2
	
	dateTree.add_child(cont)
	
	return event
	
	
	
func remove_event(index):
	for i in range(index + 1,dateTree.get_child_count()):
		dateTree.get_children()[i].get_children()[-1].switch(null)
		dateTree.get_children()[i].get_children()[-1].index -= 1
	
func enter_edit(target):
	editTarget = target
	

func exit_edit():
	editTarget = null
	save_tree_json()
	#camerapos = ogcampos

func _ready() -> void:
	#$Line2D.global_position = Vector2(0,20)
	$Line2D.add_point(Vector2(0,0))
	$Camera2D.global_position = $Line2D.points[0]
	$Line2D.add_point(Vector2(0,5000))
	
	for i in get_tree_json():
		var date = add_event()
		date.load_from_json(i)
	


func _physics_process(delta: float) -> void:
	
	var last = $VBoxContainer.get_children()[-1].get_global_rect()
	$Line2D.points[-1].y = lerp($Line2D.points[-1].y,last.position.y + last.size.y,0.1)
	
	v = lerp(v,0.,0.4)
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		v = lastpos.y - get_viewport().get_mouse_position().y
	
	if(Input.is_action_just_pressed("mwd")):
		v = lerp(v,speed,0.4)
	elif(Input.is_action_just_pressed("mwu")):
		v = lerp(v,-speed,0.4)
	
	camerapos.y += v
	
	if(not editTarget):
		camerapos.y = clamp(camerapos.y,$Line2D.points[0].y,last.position.y + last.size.y)
		$Camera2D.position.x = lerp($Camera2D.position.x,0.,0.17)
		$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(0.8,0.8),0.1)
	else:
		var center = editTarget.global_position + editTarget.size / 2
		camerapos.y = clamp(camerapos.y,editTarget.global_position.y,editTarget.global_position.y + editTarget.get_global_rect().size.y)
		$Camera2D.position.x = lerp($Camera2D.position.x,center.x,0.12)
		$Camera2D.zoom = lerp($Camera2D.zoom,Vector2(0.7,0.7),0.1)

	lastpos = get_viewport().get_mouse_position()
	$Camera2D.position.y = lerp($Camera2D.position.y,camerapos.y,0.17)


func _on_button_pressed() -> void:
	add_event()



func get_tree_json():
	if(FileAccess.file_exists("user://test.json")):
		var save = FileAccess.open("user://test.json", FileAccess.READ)
		var json = JSON.parse_string(save.get_line())
		
		return json
	
	return []

func save_tree_json():
	var dates = []
	for i in dateTree.get_children():
		dates.append(i.get_children()[-1].get_json_data())
	
	var save = FileAccess.open("user://test.json",FileAccess.WRITE)
	save.store_line(JSON.stringify(dates))
