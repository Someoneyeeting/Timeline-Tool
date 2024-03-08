extends Control

signal enterEdit
signal exitEdit
var image : Texture2D
#@onready var ri = $PanelContainer/MarginContainer/VSplitContainer/RichTextLabel

@onready var dateroot

var title = "Title"
var body = "Body"
var editmode = false
var is_hovered = false
var dragpos = null
var ogpos = 0
var imagesize = 210.0



func _ready() -> void:
	%Image.material = %Image.material.duplicate()
	
	
	#exit_edit()
	enter_edit(true)
	#connect("enterEdit",enter_edit)
	#connect("exitEdit",exit_edit)
	$AnimationPlayer.play("Create")

func enter_edit(event):
	editmode = true
	
	$VSplitContainer/Image/Button.show()
	
	%RichTextLabel.hide()
	%Labeledit.text = title
	%TextEdit.text = body
	%Label.hide()
	%Labeledit.show()
	%TextEdit.show()
	$TextureButton.hide()
	
func exit_edit():
	editmode = false
	
	$VSplitContainer/Image/Button.hide()
	
	
	title = %Labeledit.text
	body = %TextEdit.text
	%Label.show()
	%Labeledit.hide()
	%TextEdit.hide()
	%RichTextLabel.show()
	#$TextureButton.show()

func _physics_process(delta: float) -> void:
	
	custom_minimum_size.y = (%RichTextLabel.global_position - global_position).y + %RichTextLabel.size.y
	%RichTextLabel.text = body
	%Label.text = title
	
	if(Input.is_action_just_pressed("ui_cancel") and editmode):
		#emit_signal("exitEdit")
		pass
	
	
	if(editmode):
		if(Input.is_action_just_pressed("click") and not get_rect().has_point(get_local_mouse_position())):
			#emit_signal("exitEdit")
			pass
	
	if(image):
		
		$VSplitContainer/Image/Sprite2D.texture = image
		var sc = %Image.size.x / image.get_size().x
		$VSplitContainer/Image/Sprite2D.scale = Vector2(sc,sc)
		
		var imgsize = min(image.get_height() * sc,imagesize)
		
		if($VSplitContainer/Image/Button.is_hovered()):
			if(Input.is_action_just_pressed("rclick")):
				dragpos = get_global_mouse_position().y
				ogpos = $VSplitContainer/Image/Sprite2D.position.y
				$VSplitContainer/Image/Sprite2D.show()
		
		$VSplitContainer/Image/Button.visible = not dragpos
		$VSplitContainer/Image/Button.modulate.a = 0.4 if $VSplitContainer/Image/Button.is_hovered() else 0
		
		if(dragpos):
			$VSplitContainer/Image/Sprite2D.position.y = ogpos + get_global_mouse_position().y - dragpos
			$VSplitContainer/Image/Sprite2D.position.y = clamp($VSplitContainer/Image/Sprite2D.position.y,-(image.get_size().y * sc - %Image.size.y),0)
		
		%Image.material.set_shader_parameter("off",($VSplitContainer/Image/Sprite2D.position.y / -(image.get_size().y * sc)))
		
		if(not Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)):
			dragpos = null
			$VSplitContainer/Image/Sprite2D.hide()

		var size = %Image.size
		%Image.material.set_shader_parameter("image",image)
		var stretch = (float(image.get_width()) / float(image.get_height())) * (size.y / size.x)
		%Image.material.set_shader_parameter("stretch",stretch)
		%Image.show()
		%Body.add_theme_constant_override("corner_radius_top_right",0)
		%Body.add_theme_constant_override("corner_radius_top_left",0)
		
		%Image.custom_minimum_size.y = lerp(%Image.custom_minimum_size.y,imgsize,0.2)
	else:
		if(editmode):
			%Image.custom_minimum_size.y = lerp(%Image.custom_minimum_size.y,imagesize,0.2)
		else:
			%Image.custom_minimum_size.y = lerp(%Image.custom_minimum_size.y,0.,0.2)
	
	$TextureButton.size.y = 0
			

func _draw() -> void:
	pass
	#print($TextureButton.get_global_rect().size)
	#for i in get_children():
		#if(i is Control):
			#draw_rect(Rect2(i.global_position - global_position,i.get_global_rect().size),Color.RED,false,4)

func _on_texture_button_pressed() -> void:
	print("AAAAAAAAAA")
	if(not dateroot.timeroot.editTarget):
		#emit_signal("enterEdit",self)
		pass


func _on_button_pressed() -> void:
	$ImageSelect.popup()


func _on_image_select_file_selected(path: String) -> void:
	$VSplitContainer/Image/Sprite2D.position.y = 0
	var img = Image.new()
	img.load(path)
	
	var image_texture = ImageTexture.new()
	image_texture.set_image(img)
	image = image_texture
