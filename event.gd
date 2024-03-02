extends Control



@export var image : Texture2D
@export var title = ""
var text = ""

@onready var ri = $VSplitContainer/PanelContainer/MarginContainer/VSplitContainer/RichTextLabel



func _physics_process(delta: float) -> void:
	custom_minimum_size.y = (ri.global_position - global_position).y + ri.size.y
	ri.text = text
	if(image):
		var size = $VSplitContainer/Panel.size
		$VSplitContainer/Panel.material.set_shader_parameter("image",image)
		var stretch = (float(image.get_width()) / float(image.get_height())) * (size.y / size.x)
		$VSplitContainer/Panel.material.set_shader_parameter("stretch",stretch)
		$VSplitContainer/Panel.show()
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_right",0)
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_left",0)
	else:
		$VSplitContainer/Panel.hide()
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_right",30)
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_left",30)
