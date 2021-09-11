extends Area2D

onready var light :Light2D = $Light2D
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	light.hide()
	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_EnterBlock_body_entered(body: Node) -> void:
	self.show()
	light.show()
	print("dfsrfgg")
