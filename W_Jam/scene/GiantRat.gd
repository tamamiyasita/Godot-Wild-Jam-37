extends Area2D

export var hp : int = 18000
export var max_hp : int = 18000

onready var hp_text : RichTextLabel = $HPbox/Hptext
onready var hp_bar : TextureProgress = $HPbox/HpBar
var counter := 0

func _ready() -> void:
	hp_bar.max_value = max_hp
	hp_bar.value = hp
	hp_text.bbcode_text = "HP {0} / {1}".format([hp, max_hp])

func update_hp(damage) -> void:
	hp -= damage
	hp_text.bbcode_text = "HP {0} / {1}".format([hp, max_hp])
	hp_bar.value = hp
	if hp < 1:
		get_tree().call_group("enemy_scene", "Game_clear")
		
#		get_tree().quit()
		# GAME END
	else:
		counter += 1
		
		if counter >= 2:
			counter = 0
			yield(get_tree().create_timer(2), "timeout")
			get_tree().call_group("enemy_scene", "counter")


func _on_EnemyScene_update_hp(damage) -> void:
	update_hp(damage)
