extends PanelContainer

const EVENT = preload("res://event.tscn")


signal enterEdit(event)
signal exitEdit

var events = []
@onready var timeroot


@onready var eventTree = $Date/VBoxContainer/Events

func _ready():
	enterEdit.connect(timeroot.enter_edit)
	exitEdit.connect(timeroot.exit_edit)
	
	enterEdit.connect(enter_edit)
	exitEdit.connect(exit_edit)


func enter_edit(event):
	%FocusBtn.hide()

func exit_edit():
	%FocusBtn.show()

func add_event():
	var event = EVENT.instantiate()
	var cont = VBoxContainer.new()
	cont.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	cont.add_child(event)
	
	event.body = "A".repeat(randi_range(10,30))
	event.dateroot = self
	
	enterEdit.connect(event.enter_edit)
	exitEdit.connect(event.exit_edit)
	
	eventTree.add_child(cont)
	
	events.append(event)
	


func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("click")):
		if(not get_global_rect().has_point(get_global_mouse_position()) and timeroot.editTarget == self):
			emit_signal("exitEdit")

func _physics_process(delta: float) -> void:
	if(not $Date/VBoxContainer/Button.is_hovered()):
		$Date/VBoxContainer/Button/Panel.size.y = lerp($Date/VBoxContainer/Button/Panel.size.y,0.,0.4)
	else:
		$Date/VBoxContainer/Button/Panel.size.y = lerp($Date/VBoxContainer/Button/Panel.size.y,50.,0.4)
	if(len($Date/VBoxContainer/Events.get_children()) == 0):
		$Date/VBoxContainer.size.x = 0
	else:
		$Date/VBoxContainer.size.x = $Date/VBoxContainer/Events.size.x
		


func _on_button_pressed() -> void:
	add_event()


func _on_texture_button_pressed() -> void:
	emit_signal("enterEdit",self)
