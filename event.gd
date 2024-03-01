@tool
extends Control



@export var image : Texture2D



func _physics_process(delta: float) -> void:
	if(image):
		var size = $VSplitContainer/Panel.size
		$VSplitContainer/Panel.material.set_shader_parameter("image",image)
		var stretch = (float(image.get_width()) / float(image.get_height())) * (size.y / size.x)
		
		#print(stretch)
		#print(image.get_width()," ",image.get_height()," ",size.x," ",size.y)
		#print((image.get_height() / image.get_width()) * (size.x / size.y))
		$VSplitContainer/Panel.material.set_shader_parameter("stretch",stretch)
		$VSplitContainer/Panel.show()
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_right",0)
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_left",0)
	else:
		$VSplitContainer/Panel.hide()
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_right",30)
		$VSplitContainer/PanelContainer.add_theme_constant_override("corner_radius_top_left",30)
