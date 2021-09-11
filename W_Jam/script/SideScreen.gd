extends CanvasLayer

onready var power_meter1 : TextureProgress = $MarginContainer/Panel/HBoxContainer/PowerMeter1
onready var power_meter2 : TextureProgress = $MarginContainer/Panel/HBoxContainer/PowerMeter2
onready var stop_button1 : Button = $Panel/StopButton1
onready var stop_button2 : Button = $Panel/StopButton2
onready var anime1 : AnimationPlayer = $MarginContainer/Panel/HBoxContainer2/StopButton1/AnimationPlayer
onready var anime2 : AnimationPlayer = $MarginContainer/Panel/HBoxContainer2/StopButton2/AnimationPlayer
var attack_power := 0
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_StopButton_pressed() -> void:
	anime1.stop()
	attack_power = power_meter1.value
	print(attack_power)


func _on_StopButton2_pressed() -> void:
	anime2.stop()
	attack_power = power_meter2.value
	print(attack_power)
