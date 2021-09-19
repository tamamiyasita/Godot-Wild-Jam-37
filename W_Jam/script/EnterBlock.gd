extends Area2D

onready var anime :AnimationPlayer = $PowerMeter1/AnimationPlayer
onready var light :Light2D = $Light2D
onready var power_meter  :TextureProgress = $PowerMeter1



func _ready() -> void:
	switch_reset()


func switch_reset() -> void:
	light.hide()
	$Sprite.frame = 0
	anime.play('default')


func _on_EnterBlock_body_entered(body: Node) -> void:
	light.show()
	$Sprite.frame = 1
	body.is_block_push()
	anime.stop()
	var value = power_meter.value
	get_tree().call_group("main", "power_set", value)
	print("block_push")
	$AudioStreamPlayer.play()


func _on_Main_switch_reset() -> void:
	switch_reset()
