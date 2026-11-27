extends Node

@warning_ignore("unused_signal") signal body_created(body : Node2D)
@warning_ignore("unused_signal") signal time_scale_changed(value : float)

const GRAVITATIONAL_CONST : float = 6.6743 * pow(10, -11)
var time_scale : float = 1.0


func scientific_num_display(num : float):
	var main : float = log(num)/log(10)
	var exponent : int = floori(main)
	
	main -= exponent
	main = pow(10, main)
	
	main = round(main*100)
	main /= 100
	
	return str(main) + "e" + str(exponent)
