extends CanvasLayer

onready var power_meter1 : TextureProgress = $MarginContainer/Panel/HBoxContainer/PowerMeter1
onready var power_meter2 : TextureProgress = $MarginContainer/Panel/HBoxContainer/PowerMeter2
onready var stop_button1 : Button = $Panel/StopButton1
onready var stop_button2 : Button = $Panel/StopButton2
onready var anime1 : AnimationPlayer = $MarginContainer/Panel/HBoxContainer2/CenterContainer/AnimationPlayer
onready var anime2 : AnimationPlayer = $MarginContainer/Panel/HBoxContainer2/CenterContainer2/AnimationPlayer
var left_attack_power := 0
var right_attack_power := 0



