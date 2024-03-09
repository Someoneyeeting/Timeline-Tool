extends Button


#func _ready():
	#$Panel.size.y = 50
	


func _process(delta: float) -> void:
	if(not is_hovered()):
		$Panel.size.y = lerp($Panel.size.y,0.,0.4)
	else:
		$Panel.size.y = lerp($Panel.size.y,50.,0.4)
