extends CanvasLayer

@onready var info_container = $InfoContainer
@onready var spin_box = $SliderContainer/HBoxContainer/SpinBox
@onready var h_slider = $SliderContainer/HSlider

@onready var body_labels_preload = preload("res://scenes/body_labels.tscn")
@onready var body_creator_preload = preload("res://scenes/body_creator.tscn")

var body_creator : Control

func _ready():
	Global.time_scale_changed.connect(_on_h_slider_value_changed)


func _input(event : InputEvent):
	if event.is_action_pressed("create_body"):
		instantiate_body_creator(event.position)
	if event.is_action_pressed("pause"):
		if h_slider.value == 0:
			_on_h_slider_value_changed(1)
		else:
			_on_h_slider_value_changed(0)
	if body_creator == null:
		return
	
	if event.is_action_pressed("enter"):
		body_creator._on_submit_button_pressed()
	if event.is_action_pressed("esc"):
		Global.time_scale = 1
		body_creator.queue_free()
	if event.is_action_pressed("left_click"):
		if (event.position.x < body_creator.position.x || event.position.x > body_creator.position.x + body_creator.size.x || 
			event.position.y < body_creator.position.y || event.position.y > body_creator.position.y + body_creator.size.y):
			Global.time_scale = 1
			body_creator.queue_free()


func instantiate_body_creator(mouse_position : Vector2):
	if body_creator != null:
		body_creator.queue_free()
	
	h_slider.value = 0
	
	var camera : Camera2D = get_parent().get_node("Camera2D")
	
	body_creator = body_creator_preload.instantiate()
	add_child(body_creator)
	
	body_creator.position = mouse_position
	if get_window().size.y - body_creator.position.y <= body_creator.get_size().y:
		body_creator.position.y -= body_creator.get_size().y
	if get_window().size.x - body_creator.position.x < body_creator.get_size().x:
		body_creator.position.x -= body_creator.get_size().x
	
	body_creator.set_body_position(camera.get_global_mouse_position())


func _on_spin_box_value_changed(value):
	h_slider.value = value
	
	Global.time_scale = value


func _on_h_slider_value_changed(value):
	spin_box.value = value
