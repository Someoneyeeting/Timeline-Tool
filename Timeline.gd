extends Node2D


var a = 0
var v = 0.0

var speed = 20.0

const EVENT = preload("res://event.tscn")

func _ready() -> void:
	$Line2D.global_position = Vector2(0,20)
	$Line2D.add_point(Vector2(0,0))
	$Line2D.add_point(Vector2(0,get_viewport().size.y * 4))
	$Camera2D.global_position = $Line2D.points[0]
	var poses = [Vector2(40,40),Vector2(40,540),Vector2(-500,1040)]
	
	for i in poses:
		var event = EVENT.instantiate()
		
		event.global_position = i
		
		add_child(event)
	
	


func _physics_process(delta: float) -> void:
	v = lerp(v,0.0,0.1)
	print(v)
	if(Input.is_action_just_pressed("mwd")):
		v = lerp(v,speed,0.4)
	elif(Input.is_action_just_pressed("mwu")):
		v = lerp(v,-speed,0.4)
	
	$Camera2D.position.y += v
	$Camera2D.position.y = clamp($Camera2D.position.y,$Line2D.points[0].y,$Line2D.points[1].y)
