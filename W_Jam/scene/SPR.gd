extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var anime :AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anime.play('sp')
	yield(anime, "animation_finished" )
	get_tree().change_scene("res://scene/OpText.tscn") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
