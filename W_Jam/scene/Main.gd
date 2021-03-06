extends Node

onready var Robo : StaticBody2D = $PlayerScene/MajinRouZ
onready var anime : AnimationPlayer = $AnimationPlayer

onready var player_scene :Node2D = $PlayerScene
onready var enemy_scene:Node2D = $EnemyScene
onready var damage_timer :Timer = $DamageTimer

enum {TURN_READY, POWER_READY, POWER_ON, TARGET_READY, TARGET_SET, TURN_END, ENEMY_TURN, TIME_START, ENEMY_END}
enum {non_arrow, sit_arrow, power_arrow, target_arrow, change_scene}
export var state = TURN_READY
var anime_state = non_arrow

var punch_damage := 0

var is_have_left_hand := true
var is_have_right_hand := true

var is_sit := false
var switch_count := 0
var time_damage = 0

signal hp_change
signal switch_reset

func _ready() -> void:
	$BGM.play()

	set_process(false)
	
	anime.play('reset')
	get_tree().call_group("talk", "opening")
	player_turn()
	yield(get_tree().create_timer(3.5), "timeout")
	get_tree().call_group("door", "stand_move")
	set_process(true)
	anime.play('power_arrow')
	get_tree().call_group("door", "door1_open")
	emit_signal('switch_reset')
	$Warning.hide()
	

func start() -> void:
	is_have_left_hand = true
	is_have_right_hand = true
	anime.play('reset')
	emit_signal('switch_reset')
	get_tree().call_group("talk", "update_attack_text")
	anime.play('power_arrow')
	player_turn()
	$Warning.hide()
	get_tree().call_group("majin", "default")
	get_tree().call_group("door", "door1_open")
	


func _process(delta: float) -> void:
		
	
	match state:
		TURN_READY:
			start()
			state = POWER_READY
			

		POWER_ON:
			if is_sit == true:
				
				print("ロケットパーンチ！")
				punch()
				get_tree().call_group("talk", "update_shot_text")
				get_tree().call_group("door", "door2_open")
#				get_tree().call_group("door", "door1_close")
				anime_play("target_arrow")
				state = TARGET_READY
		TARGET_READY:
			yield(anime, "animation_finished" )	
			enemy_window_change()
			get_tree().call_group("enemy_scene", "start_turn")
			
			state = ENEMY_TURN
		TIME_START:
			if is_sit == true and time_damage == 0:
				get_tree().call_group("majin", "gurd")
				time_damage = damage_timer.time_left
				print(damage_timer.time_left, "time_damage!!!", time_damage)
				damage_timer.stop()
			
			
		ENEMY_END:
			if is_sit == true:
				print("Eneme_turn")
				get_tree().call_group("door", "door2_close")
				state = TURN_READY
				
#			yield(anime, "animation_finished" )	
#			anime_play("")
			
		



func anime_play(name) -> void:
	anime.play(name)
	yield(anime, "animation_finished" )
	anime_state = non_arrow


func sit()->void:
	is_sit = !is_sit
	if is_sit == true:
		$CrickSound.play()
		yield(get_tree().create_timer(.56), "timeout")
		$CrickSound2.play()

func power_set(value) -> void:
	punch_damage = value
	print(punch_damage, " punch damage")
	
	
func punch():
	get_tree().call_group("majin", "punch")


func enemy_window_change() -> void:
	anime_play('window_change')
func player_window_change() -> void:
	anime_play('window_change2')
	yield(anime, "animation_finished" )
	anime.play('damage')
	yield(anime, "animation_finished" )
	damage_pop()

func player_turn() -> void:
	get_tree().call_group("player_scene", "player_turn")
	get_tree().call_group("enemy_scene", "player_turn")
	enemy_scene.hide()
	player_scene.show()
func enemy_turn() -> void:
	get_tree().call_group("player_scene", "enemy_turn")
	get_tree().call_group("enemy_scene", "enemy_turn")
	player_scene.hide()
	enemy_scene.show()


func damage_pop()->void:
	get_tree().call_group("door", "door1_close")				
	yield(get_tree().create_timer(.3), "timeout")

	var damage_wait :int = int(damage_timer.wait_time - time_damage) 
	time_damage = 0
	
	print("damage_wait = ", damage_wait)
	var damage = (damage_wait*100) * damage_wait
	$Damagetext.bbcode_text = str(damage)
	emit_signal('hp_change', damage)
	
	yield(get_tree().create_timer(.5), "timeout")
	
	if Robo.hp < 1:
		Game_Over()
	else:
		yield(get_tree().create_timer(.5), "timeout")
		get_tree().call_group("talk", "update_damage_text")
		yield(get_tree().create_timer(.5), "timeout")
		$Damagetext.bbcode_text = ""
		anime.play('sit_arrow')
		yield(get_tree().create_timer(.3), "timeout")
		anime.stop()
		anime.play('reset')
		state = ENEMY_END

func Game_Over()->void:
		set_process(false)
		$Dead.dead()
		yield(get_tree().create_timer(2.5), "timeout")
		$Dead.stop()
		get_tree().call_group("majin", "Game_Over")

func _on_PowerBlock_body_entered(body: Node) -> void:
	state = POWER_ON
	anime_play("sit_arrow")
	get_tree().call_group("majin", "punch_ready")
	$PowerON.play()
	
	set_process(true)
	print("power_on!")


func _on_TargetBlock_body_entered(body: Node) -> void:
	if is_have_right_hand:
		print("Right_on")
		get_tree().call_group("enemy_scene", "right_stop", punch_damage)
		switch_count += 1
		is_have_right_hand = false
		if switch_count >= 2:
			damage_timer_start()

func _on_TargetBlock2_body_entered(body: Node) -> void:
	if is_have_left_hand:
		print("Left_on")
		get_tree().call_group("enemy_scene", "left_stop", punch_damage)
		switch_count += 1
		is_have_left_hand = false
		if switch_count >= 2:
			damage_timer_start()

func damage_timer_start() -> void:
	anime_play("sit_arrow")
	switch_count = 0
	damage_timer.start(0)
	state = TIME_START
	$Warning.show()
	yield(get_tree().create_timer(2.1), "timeout")
	$Warning.hide()
	
