extends Node2D




var a = 0
var v = 0.0

var editTarget

var speed = 70.0
var lastpos = Vector2(0,0)

var camerapos = Vector2(0,0)
var ogcampos = Vector2(0,0)

var DATE = preload("res://date.tscn")

func add_event():
	var left
	if($VBoxContainer/Dates.get_child_count() > 0):
		left = not ($VBoxContainer/Dates.get_children()[-1].get_children()[-1].left)
	else:
		left = true
		
	var event = DATE.instantiate()
	var cont = HBoxContainer.new()
	cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	if(not left):
		var sep = Container.new()
		cont.add_child(sep)
		sep.custom_minimum_size.x = 510
	
	event.timeroot = self
	
	event.left = left
	
	cont.add_child(event)
	
	v = event.size.y
	
	$VBoxContainer/Dates.add_child(cont)
	
	
func enter_edit(target):
	editTarget = target
	

func exit_edit():
	editTarget = null
	#camerapos = ogcampos

func _ready() -> void:
	#$Line2D.global_position = Vector2(0,20)
	$Line2D.add_point(Vector2(0,0))
	$Camera2D.global_position = $Line2D.points[0]
	$Line2D.add_point(Vector2(0,5000))
	


func _physics_process(delta: float) -> void:
	
	var last = $VBoxContainer.get_children()[-1].get_global_rect()
	$Line2D.points[-1].y = lerp($Line2D.points[-1].y,last.position.y + last.size.y + 50,0.1)
	
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
