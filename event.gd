extends Control



@export var image : Texture2D
@export var title = ""
#@onready var ri = $PanelContainer/MarginContainer/VSplitContainer/RichTextLabel

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
	custom_minimum_size.y = (%RichTextLabel.global_position - global_position).y + %RichTextLabel.size.y
	%RichTextLabel.text = text
	
	if(Input.is_action_just_pressed("click") and is_hovered):
		print("fuck")
		if(editmode):
			exit_edit(false)
		else:
			enter_edit()
	
	if(image):
		var size = %Image.size
		%Image.material.set_shader_parameter("image",image)
		var stretch = (float(image.get_width()) / float(image.get_height())) * (size.y / size.x)
		%Image.material.set_shader_parameter("stretch",stretch)
		%Image.show()
		%Body.add_theme_constant_override("corner_radius_top_right",0)
		%Body.add_theme_constant_override("corner_radius_top_left",0)
	else:
		%Image.hide()
		%Body.add_theme_constant_override("corner_radius_top_right",30)
		%Body.add_theme_constant_override("corner_radius_top_left",30)



func _on_texture_button_pressed() -> void:
	print("fuck")
