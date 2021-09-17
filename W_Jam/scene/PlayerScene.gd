extends Node2D

#func _ready() -> void:
#	yield(get_tree().create_timer(1.5), "timeout")
#	turn_change()


func enemy_turn() -> void:
	$ParallaxBackground.process_off()
	
func player_turn() -> void:
	$ParallaxBackground.process_on()
	
