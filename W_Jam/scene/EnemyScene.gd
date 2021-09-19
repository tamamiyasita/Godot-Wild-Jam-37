extends Node2D

onready var tween : Tween = $Tween
onready var left_target : Area2D = $Targets/Left
onready var left_hand : Sprite = $L_punch

onready var right_target : Area2D = $Targets/Right
onready var right_hand : Sprite = $R_punch

onready var left_anime :AnimationPlayer = $Leftanime
onready var right_anime :AnimationPlayer = $Rightanime

onready var giant_rat :Area2D = $GiantRat

var is_right_hit_zone :bool = false
var is_left_hit_zone :bool = false

signal update_hp

func _ready() -> void:
	pass
#	start_turn()
	# TEST
#	yield(get_tree().create_timer(.55), "timeout")
#	right_stop(90)
#	left_stop(70)
func start_turn() -> void:
	left_anime.play('left_move')
	right_anime.play('right_move')
	$Targets/Left/Sprite.show()
	$Targets/Right/Sprite.show()
	
func counter() -> void:
	yield(get_tree().create_timer(2), "timeout")
	left_anime.play('Beam')
#	yield(left_anime, "animation_finished" )
	yield(get_tree().create_timer(.5), "timeout")
	get_tree().call_group("main", "player_window_change")


func damage_pop_2(damage)->void:
	yield(get_tree().create_timer(.6), "timeout")
	$Damagetext2.bbcode_text = str(damage)
	yield(get_tree().create_timer(1.5), "timeout")
	$Damagetext2.bbcode_text = ""

func damage_pop_1(damage)->void:
	yield(get_tree().create_timer(.6), "timeout")
	$Damagetext1.bbcode_text = str(damage)
	yield(get_tree().create_timer(1.5), "timeout")
	$Damagetext1.bbcode_text = ""


func left_stop(damage) -> void:
	var amount = 0
	left_anime.stop()
	left_attack_start()
	var pos = giant_rat.position.distance_to(left_target.position)
	print("pos = ",pos)
	yield(get_tree().create_timer(.2), "timeout")
	if is_left_hit_zone:
#		amount = int((damage*2.5 + int(pos)*1.5) * 6.2)
		amount = int((damage*35.5 + int(pos)*3.5))
		
#		giant_rat.hp -= amount
		print(giant_rat.hp, " = HP   ", amount, " = amount")
		damage_pop_2(amount)
	emit_signal('update_hp', amount)
		
func right_stop(damage) -> void:
	var amount = 0
	right_anime.stop()
	right_attack_start()
	var pos = giant_rat.position.distance_to(right_target.position)
	print("pos = ",pos)
	yield(get_tree().create_timer(.2), "timeout")
	if is_right_hit_zone:
		amount = int((damage*35.5 + int(pos)*3.5))
#		amount = int((damage*2.5 + int(pos)*1.5) * 6.2)
#		giant_rat.hp -= amount
		print(giant_rat.hp, " = HP   ", amount, " = amount")
		damage_pop_1(amount)
	emit_signal('update_hp', amount)
		
func right_attack_start() -> void:
	tween.interpolate_property(
		right_hand,
		"global_position",
		right_hand.global_position,
		right_target.global_position,
		.6,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()
	right_anime.play('right_shot')

func right_attack_end() -> void:
	tween.interpolate_property(
		right_hand,
		"global_position",
		right_target.global_position,
		Vector2(0,0),
		.6,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()
	
	
func left_attack_start() -> void:
	tween.interpolate_property(
		left_hand,
		"global_position",
		left_hand.global_position,
		left_target.global_position,
		.6,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()
	left_anime.play('left_shot')

func left_attack_end() -> void:
	tween.interpolate_property(
		left_hand,
		"global_position",
		left_target.global_position,
		Vector2(0,0),
		.6,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()

func Game_clear() -> void:
#	left_anime.play('dead')
#	yield(left_anime, "animation_finished" )
	$Dead.dead()
	yield(get_tree().create_timer(4.5), "timeout")
	$Dead.stop()
	get_tree().change_scene("res://scene/END.tscn")



func _on_Right_area_entered(area: Area2D) -> void:
	is_right_hit_zone = true
	print("Right_hit_zone_in")
func _on_Right_area_exited(area: Area2D) -> void:
	is_right_hit_zone = false



func _on_Left_area_entered(area: Area2D) -> void:
	is_left_hit_zone = true
	print("Left_hit_zone_in")
func _on_Left_area_exited(area: Area2D) -> void:
	is_left_hit_zone = false



func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	print(object, " = object", key, " = key")
	if object == right_hand and is_right_hit_zone == true:
		print("right_HIT")
		right_anime.play('right_burst')
		
	if object == left_hand and is_left_hit_zone == true:
		print("left_HIT")
		left_anime.play('left_burst')

func enemy_turn() -> void:
	$E_ParallaxBackground.process_on()
	start_turn()
	
func player_turn() -> void:
	$E_ParallaxBackground.process_off()
