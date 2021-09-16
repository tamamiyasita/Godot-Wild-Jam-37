extends StaticBody2D



func _on_Area2D_body_entered(body: Node) -> void:
	body.hide()
	$Sprite2.show()
	get_tree().call_group("main", "sit")

func _on_Area2D_body_exited(body: Node) -> void:
	body.show()
	$Sprite2.hide()
	get_tree().call_group("main", "sit")
