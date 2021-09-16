extends Area2D

onready var light :Light2D = $Light2D
onready var red_light :Light2D = $Switch/RedLight
onready var green_light :Light2D = $Switch/GreenLight
onready var icon_light :Light2D = $Icon/Light2D



func _ready() -> void:
	switch_reset()

func switch_reset() -> void:
	light.hide()
	red_light.show()
	green_light.hide()
	icon_light.hide()



func _on_TargetBlock_body_entered(body: Node) -> void:
	light.show()
	red_light.hide()
	green_light.show()
	icon_light.show()
	
	$Sprite.frame = 1
	body.is_block_push()
	print("tar_block_push")

