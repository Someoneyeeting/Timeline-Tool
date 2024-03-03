extends Control



@export var image : Texture2D
@export var title = ""
var text = ""
@onready var ri = $PanelContainer/MarginContainer/VSplitContainer/RichTextLabel


func _ready() -> void:
	$AnimationPlayer.play("Create")

func _physics_process(delta: float) -> void:
	custom_minimum_size.y = (ri.global_position - global_position).y + ri.size.y
	ri.text = text
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
