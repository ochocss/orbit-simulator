extends Node2D

@onready var body_preload = preload("res://scenes/body.tscn")

@onready var camera_2d = $Camera2D
@onready var ui = $UI


func _ready():
	Global.body_created.connect(new_body)


func _process(_delta):
	var speed = 15*(1/camera_2d.zoom.x)
	var zoom = 1.2
	
	if Input.is_action_pressed("speed_up"):
		speed *= 1.8
		zoom *= 1.5
	
	if Input.is_action_just_pressed("zoom_in") || Input.is_action_pressed("zoom_in"):
		camera_2d.zoom.x *= zoom
		camera_2d.zoom.y *= zoom
	if (Input.is_action_just_pressed("zoom_out") || Input.is_action_pressed("zoom_out")) && camera_2d.zoom.x-0.03 > 0.0:
		camera_2d.zoom.x /= zoom
		camera_2d.zoom.y /= zoom
	
	if Input.is_action_pressed("up"):
		camera_2d.position.y -= speed
	if Input.is_action_pressed("down"):
		camera_2d.position.y += speed
	if Input.is_action_pressed("left"):
		camera_2d.position.x -= speed
	if Input.is_action_pressed("right"):
		camera_2d.position.x += speed


func new_body(body : Node2D):
	add_child(body)
