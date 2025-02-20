extends Node2D

@onready var body_preload = preload("res://scenes/body.tscn")

@onready var camera_2d = $Camera2D
@onready var ui = $UI


func _ready():
	Global.body_created.connect(new_body)


func _process(_delta):
	if Input.is_action_just_pressed("zoom_in") || Input.is_action_pressed("zoom_in"):
		camera_2d.zoom.x += 0.03
		camera_2d.zoom.y += 0.03
	if (Input.is_action_just_pressed("zoom_out") || Input.is_action_pressed("zoom_out")) && camera_2d.zoom.x-0.03 > 0.0:
		camera_2d.zoom.x -= 0.03
		camera_2d.zoom.y -= 0.03
	
	if Input.is_action_pressed("up"):
		camera_2d.position.y -= 10
	if Input.is_action_pressed("down"):
		camera_2d.position.y += 10
	if Input.is_action_pressed("left"):
		camera_2d.position.x -= 10
	if Input.is_action_pressed("right"):
		camera_2d.position.x += 10


func new_body(body : Node2D):
	add_child(body)
