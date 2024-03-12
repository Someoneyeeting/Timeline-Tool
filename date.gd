extends PanelContainer

const EVENT = preload("res://event.tscn")


signal enterEdit(event)
signal exitEdit
signal delete

var left = false
var index = -1

var events = []
@onready var timeroot

@onready var eventTree = $Date/VBoxContainer/Events

var clickt = 0

func _ready():
	$AnimationPlayer.play("Create")
	enterEdit.connect(timeroot.enter_edit)
	exitEdit.connect(timeroot.exit_edit)
	
	enterEdit.connect(enter_edit)
	exitEdit.connect(exit_edit)
	
	delete.connect(_delete)
	
	%FocusBtn.show()
	
	$Date/LineEdit.text = $Date/Label.text
		
	switch(left)
	
	

func switch(left):
	if(left == null):
		left = not self.left
	self.left = left
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CIRC)
	tween.set_ease(Tween.EASE_OUT)
	if(left):
		$Date/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		$Date/LineEdit.alignment = HORIZONTAL_ALIGNMENT_RIGHT
		tween.tween_property(get_parent().get_child(0),"custom_minimum_size:x",0,0.3)
	else:
		$Date/Label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		$Date/LineEdit.alignment = HORIZONTAL_ALIGNMENT_LEFT
		tween.tween_property(get_parent().get_child(0),"custom_minimum_size:x",510,0.3)

func _delete(index):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self,"scale:y",0,0.2)
	tween.tween_callback(get_parent().queue_free)
	#$AnimationPlayer.play_backwards("Create")


func enter_edit(event):
	%FocusBtn.hide()
	$Date/Label.hide()
	$Date/LineEdit.show()
	$Date/LineEdit.text = $Date/Label.text
	

func exit_edit():
	%FocusBtn.show()
	$Date/Label.show()
	$Date/LineEdit.hide()
	if($Date/LineEdit.text == ""):
		delete.emit(index)
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
	var s = $Node2D/ColorRect.size.y / 2
	$Node2D.global_position.y = $Date/Label.get_global_rect().position.y + 30 - s
	$Node2D.global_position.x = -s
	
	index = timeroot.dateTree.get_children().find(get_parent())
	#if(left != (index % 2 == 0)):
		#left = index % 2 == 0
		#switch(left)

func _draw():
	#draw_rect(Rect2(get_parent().get_parent().global_position - global_position,get_parent().get_parent().get_global_rect().size),Color.WHITE,false,4)
	pass
	
func _on_button_pressed() -> void:
	add_event()


func _on_texture_button_pressed() -> void:
	if(not timeroot.editTarget):
		emit_signal("enterEdit",self)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if($Date/LineEdit.text == ""):
		get_parent().queue_free()
