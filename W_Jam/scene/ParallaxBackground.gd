extends ParallaxBackground

func process_off() -> void:
	$ParallaxLayer.hide()
	
func process_on() -> void:
	$ParallaxLayer.show()

func _process(delta: float) -> void:
	scroll_offset.x += 1000 * delta
