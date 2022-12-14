extends Node
# Make this a global singleton if you want

func shake(thing : Node2D, strength: float, duration : float = 0.2) -> void:
	var orig_pos := thing.position
	var current_amount := 4.0
	var shake_count := 10.0
	
	for i in shake_count: # Tweak these values
		var target = orig_pos + strength * current_amount * Vector2(rand_range(-1.0, 1.0), rand_range(-1.0, 1.0))
		if i % 2 == 0: target = orig_pos + Vector2.ZERO
		var tween = create_tween().tween_property(thing, "position", target, duration / shake_count)
		yield(tween, "finished")
		current_amount *= .75
		
	thing.position = orig_pos
