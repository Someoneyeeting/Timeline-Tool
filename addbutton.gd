extends Button


#func _ready():
	#$Panel.size.y = 50
	
var hovered = false

func _ready() -> void:
		$Panel.size.y = 0.

func _process(delta: float) -> void:
	if(not hovered):
		$Panel.size.y = lerp($Panel.size.y,0.,0.4)
	else:
		$Panel.size.y = lerp($Panel.size.y,50.,0.4)


func _on_mouse_entered() -> void:
	hovered = true


func _on_mouse_exited() -> void:
	hovered = false
