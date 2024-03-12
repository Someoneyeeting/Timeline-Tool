@tool
extends Node2D



var anim :float= 0.1
var t = 0

func _physics_process(delta: float) -> void:
	$Line2D2.clear_points()
	t += delta
	anim = abs(sin(t))
	print($Path2D.curve.point_count)
	var res = 20
	for i in int(res + 1):
		$Line2D2.add_point($Path2D.curve.samplef(float(i) * ($Path2D.curve.point_count - 1) * anim  / res))
