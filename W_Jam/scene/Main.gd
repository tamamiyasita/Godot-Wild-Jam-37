extends Node2D

onready var Robo : StaticBody2D = $PlayerScene/MajinRouZ

var reft_punch_damage := 0
var right_punch_damage := 0




func _ready() -> void:
	Robo.hide()
