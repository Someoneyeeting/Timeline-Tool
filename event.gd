extends Control

signal enterEdit
signal exitEdit
@export var image : Texture2D
#@onready var ri = $PanelContainer/MarginContainer/VSplitContainer/RichTextLabel

var title = "Title"
var body = ""
var editmode = false
var is_hovered = false




func _ready() -> void:
	$AnimationPlayer.play("Create")

func enter_edit():
	emit_signal("enterEdit",self)
	editmode = true
	%Labeledit.text = title
	%TextEdit.text = body
	%Label.hide()
	%Labeledit.show()
	%TextEdit.show()
	%RichTextLabel.hide()
	$TextureButton.hide()
	
func exit_edit(save):
	emit_signal("exitEdit")
	editmode = false
	title = %Labeledit.text
	body = %TextEdit.text
	%Label.show()
	%Labeledit.hide()
	%TextEdit.hide()
	%RichTextLabel.show()
	$TextureButton.show()

func _physics_process(delta: float) -> void:
	custom_minimum_size.y = (%RichTextLabel.global_position - global_position).y + %RichTextLabel.size.y
	%RichTextLabel.text = body
	%Label.text = title
	
	if(Input.is_action_just_pressed("ui_accept") and editmode):
		exit_edit(false)
	
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
		if(editmode):
			exit_edit(false)
		else:
			enter_edit()
