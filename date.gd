extends VBoxContainer

const EVENT = preload("res://event.tscn")

@onready var eventTree = $VBoxContainer/Events

func add_event():
	var event = EVENT.instantiate()
	var cont = VBoxContainer.new()
	cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	cont.add_child(event)
	
	event.text = "A".repeat(randi_range(40,600))
	
	eventTree.add_child(cont)
	

	var btn = load("res://button.tscn").instantiate()



func _physics_process(delta: float) -> void:
	queue_redraw()
	if(not $VBoxContainer/Button.is_hovered()):
		$VBoxContainer/Button/Panel.size.y = lerp($VBoxContainer/Button/Panel.size.y,0.,0.4)
	else:
		$VBoxContainer/Button/Panel.size.y = lerp($VBoxContainer/Button/Panel.size.y,50.,0.4)
	if(len($VBoxContainer/Events.get_children()) == 0):
		$VBoxContainer.size.x = 0
	else:
		$VBoxContainer.size.x = $VBoxContainer/Events.size.x
		


func _on_button_pressed() -> void:
	add_event()
