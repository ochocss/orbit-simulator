extends Control

@onready var body_preload = preload("res://scenes/body.tscn")

@onready var mass = %Mass
@onready var exponent = %Exponent
@onready var radius_number = %RadiusNumber
@onready var x_velocity = %XVelocity
@onready var y_velocity = %YVelocity
@onready var color_picker = %ColorPicker

var body_position := Vector2(0.0, 0.0)
var velocity := Vector2(0.0, 0.0)


func set_body_position(pos : Vector2):
	body_position = pos


func _on_submit_button_pressed():
	var body = body_preload.instantiate()
	body.color = color_picker.color
	body.mass = mass.value * pow(10, exponent.value)
	body.radius = radius_number.value
	body.position = body_position
	body.velocity = Vector2(x_velocity.value, y_velocity.value)
	Global.time_scale_changed.emit(1)
	Global.body_created.emit(body)
	queue_free()
