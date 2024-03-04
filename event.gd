extends Control



@export var image : Texture2D
@export var title = ""
@onready var ri = $PanelContainer/MarginContainer/VSplitContainer/RichTextLabel

var text = ""
var editmode = false
var is_hovered = false




func _ready() -> void:
	$AnimationPlayer.play("Create")

func enter_edit():
	editmode = true
	%Label.hide()
	%Labeledit.show()
	%TextEdit.show()
	%RichTextLabel.hide()
	
func exit_edit(save):
	editmode = false
	%Label.show()
	%Labeledit.hide()
	%TextEdit.hide()
	%RichTextLabel.show()

func _physics_process(delta: float) -> void:
	custom_minimum_size.y = (ri.global_position - global_position).y + ri.size.y
	ri.text = text
	
	if(Input.is_action_just_pressed("click") and is_hovered):
		print("fuck")
		if(editmode):
			exit_edit(false)
		else:
			enter_edit()
	
	if(image):
		var size = $Panel.size
		$Panel.material.set_shader_parameter("image",image)
		var stretch = (float(image.get_width()) / float(image.get_height())) * (size.y / size.x)
		$Panel.material.set_shader_parameter("stretch",stretch)
		$Panel.show()
		$PanelContainer.add_theme_constant_override("corner_radius_top_right",0)
		$PanelContainer.add_theme_constant_override("corner_radius_top_left",0)
	else:
		$Panel.hide()
		$PanelContainer.add_theme_constant_override("corner_radius_top_right",30)
		$PanelContainer.add_theme_constant_override("corner_radius_top_left",30)


func _on_label_mouse_exited() -> void:
	is_hovered = false
	print("exit")


func _on_label_mouse_entered() -> void:
	is_hovered = true
	print("enter")
