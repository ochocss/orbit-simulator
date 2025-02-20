extends Control

@onready var index_label = $IndexLabel
@onready var velocity_label = $VBoxContainer/VelocityLabel
@onready var aceleration_label = $VBoxContainer/AcelerationLabel


func set_texts(velocity : Vector2 = Vector2(0.00, 0.00), aceleration : Vector2 = Vector2(0.00, 0.00)):
	velocity_label.text = "Velocity = (" + str(snappedf(velocity.x, 0.001)) + ", " + str(snappedf(velocity.y, 0.001)) + ")"
	aceleration_label.text = "Aceleration (" + str(snappedf(aceleration.x, 0.001)) + ", " + str(snappedf(aceleration.y, 0.001)) + ")"

func set_body_index(i : int = 0):
	index_label.text = str(i)
