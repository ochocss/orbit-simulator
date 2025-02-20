extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var mass_label = $Control/MassLabel

@export var color : Color = Color(1.0, 1.0, 1.0, 1.0)
@export var mass : float = 1.35 * pow(10, 11)
@export var radius : int = 5
@export var velocity := Vector2(0.0, 0.0)
var aceleration := Vector2(0.0, 0.0)


func _ready():
	sprite_2d.material.set_shader_parameter("my_color", color)
	sprite_2d.scale = Vector2((radius*2)/300.0, (radius*2)/300.0)
	collision_shape_2d.set("shape.radius", radius)
	mass_label.text = String.num_scientific(mass)


func _physics_process(_delta):
	position.x += velocity.x * 1 * Global.time_scale
	position.y += velocity.y * 1 * Global.time_scale
	
	velocity.x += aceleration.x * 1 * Global.time_scale
	velocity.y += aceleration.y * 1 * Global.time_scale
	
	var resultant_force : Vector2
	
	var nodes : = get_tree().get_nodes_in_group("Bodies")
	for node in nodes:
		if node == self:
			continue
		
		var distance = position.distance_to(node.position)
		var angle = position.direction_to(node.position)
		var fg = (Global.GRAVITATIONAL_CONST * mass * node.mass) / (distance * distance)
		
		resultant_force.x += fg * angle.x
		resultant_force.y += fg * angle.y
	
	aceleration.x = resultant_force.x / mass
	aceleration.y = resultant_force.y / mass


func _on_area_2d_area_entered(area):
	var body : Node2D = area.get_parent()
	
	if body.mass > mass:
		return
	
	collide(body)


func collide(body : Node2D):
	var new_mass = mass + body.mass
	
	# linear momentum
	velocity.x = (body.velocity.x * body.mass + velocity.x * mass)/new_mass
	velocity.y = (body.velocity.y * body.mass + velocity.y * mass)/new_mass
	
	mass = new_mass
	mass_label.text = String.num_scientific(mass)
	
	body.queue_free()
