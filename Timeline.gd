extends Node2D


var a = 0
var v = 0.0

var speed = 20.0
var lastpos = Vector2(0,0)

const EVENT = preload("res://event.tscn")

func add_event(event,left):
	var cont = HBoxContainer.new()
	cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	if(not left):
		var sep = Container.new()
		cont.add_child(sep)
		sep.custom_minimum_size.x = 510
	
	cont.add_child(event)
	#cont.move_child(event,-2)
	
	event.text = "A".repeat(randi_range(40,600))
	
	$VBoxContainer.add_child(cont)
	
	#var 
	var btn = load("res://button.tscn").instantiate()
	
	$VBoxContainer.add_child(btn)


func _ready() -> void:
	#$Line2D.global_position = Vector2(0,20)
	$Line2D.add_point(Vector2(0,0))
	$Camera2D.global_position = $Line2D.points[0]
	$Line2D.add_point(Vector2(0,5000))
	
	for i in range(10):
		var event = EVENT.instantiate()
		
		add_event(event,i % 3 == 0)
		
		
	
		
	
	


func _physics_process(delta: float) -> void:
	
	var last = $VBoxContainer.get_children()[-1].get_global_rect()
	$Line2D.points[-1].y = last.position.y + 50
	
	v = lerp(v,0.0,0.08)
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		v = lastpos.y - get_viewport().get_mouse_position().y
	
	if(Input.is_action_just_pressed("mwd")):
		v = lerp(v,speed,0.4)
	elif(Input.is_action_just_pressed("mwu")):
		v = lerp(v,-speed,0.4)
	
	$Camera2D.position.y += v
	$Camera2D.position.y = clamp($Camera2D.position.y,$Line2D.points[0].y,last.position.y + last.size.y / 2)
	lastpos = get_viewport().get_mouse_position()