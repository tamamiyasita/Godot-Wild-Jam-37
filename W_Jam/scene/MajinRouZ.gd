extends StaticBody2D

onready var anime : AnimationPlayer = $AnimationPlayer

var shot_count := 0

func _ready() -> void:
	anime.play('default')

func punch() -> void:
	anime.play('punch')
