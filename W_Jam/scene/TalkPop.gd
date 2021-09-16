extends Sprite

onready var pop_text :Label = $PopText 
onready var anime :AnimationPlayer = $AnimationPlayer
onready var damage_text = $DamageDialogue
onready var attack_text = $AttackDialogue
onready var shot_text = $ShotDialogue

func update_attack_text() -> void:
	randomize()
	var value :int= randi() % attack_text.get_child_count()
	var message = attack_text.get_child(value)
	pop_text.text = message.message


func update_shot_text() -> void:
	randomize()
	var value :int= randi() % shot_text.get_child_count()
	var message = shot_text.get_child(value)
	pop_text.text = message.message
	
	
func update_damage_text() -> void:
	randomize()
	var value :int= randi() % damage_text.get_child_count()
	var message = damage_text.get_child(value)
	pop_text = message.message


func opening() -> void:
	$AnimationPlayer.play('Sandstorm')
	yield(anime, "animation_finished" )
	update_attack_text()
