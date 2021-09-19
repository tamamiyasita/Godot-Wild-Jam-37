extends StaticBody2D

onready var anime : AnimationPlayer = $AnimationPlayer

export var hp : int = 7900
export var max_hp : int = 7900

onready var hp_text : RichTextLabel = $HPbox/Hptext
onready var hp_bar : TextureProgress = $HPbox/HpBar


func _ready() -> void:
	anime.play('start_move')
	yield(anime, "animation_finished" )
	anime.play('default')
	hp_bar.max_value = max_hp
	hp_bar.value = hp
	hp_text.bbcode_text = "HP {0} / {1}".format([hp, max_hp])
#	Game_Over()
	
func update_hp(damage) -> void:
	hp -= damage
	hp_text.bbcode_text = "HP {0} / {1}".format([hp, max_hp])
	hp_bar.value = hp
	if hp < 1:
		pass
		
func Game_Over() -> void:
#	anime.stop()
#	anime.play('dead')
#	yield(anime, "animation_finished" )
	get_tree().change_scene("res://scene/GameOver.tscn")
	
	
func gurd() -> void:
	anime.play('gurd')

func default()->void:
	anime.play('default')
	
func punch_ready() -> void:
	anime.play('ready')

func punch() -> void:
	anime.stop()
	anime.play('punch')
	yield(get_tree().create_timer(4.5), "timeout")
	anime.play('default')


func _on_Main_hp_change(damage) -> void:
	update_hp(damage)
