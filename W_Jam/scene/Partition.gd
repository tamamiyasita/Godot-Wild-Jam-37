extends Node2D

onready var anime : AnimationPlayer = $AnimationPlayer


func door1_open() -> void:
	anime.play('door1_open')

func door1_close() -> void:
	anime.play('door1_close')

func door2_open() -> void:
	anime.play('door2_open')

func door2_close() -> void:
	yield(anime, "animation_finished" )
	anime.play('door2_close')

func stand_move() -> void:
	anime.play('stand_move')
