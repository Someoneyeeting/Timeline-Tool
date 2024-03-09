extends PanelContainer

const EVENT = preload("res://event.tscn")


signal enterEdit(event)
signal exitEdit

var left = false

var events = []
@onready var timeroot

@onready var eventTree = $Date/VBoxContainer/Events

var clickt = 0

func _ready():
	enterEdit.connect(timeroot.enter_edit)
	exitEdit.connect(timeroot.exit_edit)
	
	enterEdit.connect(enter_edit)
	exitEdit.connect(exit_edit)
	
	%FocusBtn.show()
	
	$AnimationPlayer.play("Create")
	
	if(left):
		$Date/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		$Date/LineEdit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
	else:
		$Date/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		$Date/LineEdit.alignment = HORIZONTAL_ALIGNMENT_LEFT
	

func enter_edit(event):
	%FocusBtn.hide()
	$Date/Label.hide()
	$Date/LineEdit.show()
	$Date/LineEdit.text = $Date/Label.text
	

func exit_edit():
	%FocusBtn.show()
	$Date/Label.show()
	$Date/LineEdit.hide()
	$Date/Label.text = $Date/LineEdit.text

func add_event():
	var event = EVENT.instantiate()
	var cont = VBoxContainer.new()
	cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	cont.add_child(event)
	
	event.dateroot = self
	
	enterEdit.connect(event.enter_edit)
	exitEdit.connect(event.exit_edit)
	
	eventTree.add_child(cont)
	
	events.append(event)
	


func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion):
		if(event.velocity.length() > 40):
			$clickt.stop()
	if(event.is_action_pressed("click")):
		var rect = get_global_rect()
		var s = 0
		rect.position -= Vector2(s,s)
		rect.size += Vector2(s,s) * 2
		if(not rect.has_point(get_global_mouse_position()) and timeroot.editTarget == self):
			$clickt.start()
	if(event.is_action_released("click")):
		if($clickt.time_left > 0):
			emit_signal("exitEdit")

func _physics_process(delta: float) -> void:
	pass
		

func _draw():
	pass
	#var rect = get_global_rect()
	#rect.position -= Vector2(150,150)
	#rect.position -= global_position
	#rect.size += Vector2(300,300)
	#draw_rect(rect,Color.WHITE,false,4)
	
func _on_button_pressed() -> void:
	add_event()


func _on_texture_button_pressed() -> void:
	emit_signal("enterEdit",self)
