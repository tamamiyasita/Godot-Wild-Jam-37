extends Node2D

onready var anime : AnimationPlayer = $AnimationPlayer


func door1_open() -> void:
	anime.play('door1_open')


func door2_open() -> void:
	anime.play('door2_open')
	

func stand_move() -> void:
	anime.play('stand_move')
