extends Node

@warning_ignore("unused_signal") signal body_created(body : Node2D)
@warning_ignore("unused_signal") signal time_scale_changed(value : float)

const GRAVITATIONAL_CONST : float = 6.6743 * pow(10, -11)
var time_scale : float = 1.0
