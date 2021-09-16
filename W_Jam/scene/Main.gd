extends Node2D

onready var Robo : StaticBody2D = $PlayerScene/MajinRouZ
onready var anime : AnimationPlayer = $AnimationPlayer

enum {TURN_READY, POWER_READY, POWER_ON, TARGET_READY, TARGET_SET, TURN_END}
export var state = TURN_READY

var punch_damage := 0

var is_sit := false
var in_operation := false


func _ready() -> void:
	set_process(false)
	get_tree().call_group("door", "stand_move")
	anime.play('reset')
	set_process(true)


func _process(delta: float) -> void:
	match state:
		TURN_READY:
			get_tree().call_group("talk", "opening")
			get_tree().call_group("door", "door1_open")
			state = POWER_READY
			
		POWER_READY:
			yield(get_tree().create_timer(3.5), "timeout")
			anime.play('power_arrow')
			set_process(false)
			
			

		POWER_ON:
			if is_sit == true:
				print("ロケットパーンチ！")
				punch()
				get_tree().call_group("talk", "update_shot_text")
				get_tree().call_group("door", "door2_open")
				set_process(false)
				state = TARGET_READY
				yield(get_tree().create_timer(3.0), "timeout")
				anime.play('window_change')
				

func sit()->void:
	is_sit = !is_sit

func power_set(value) -> void:
	punch_damage = value
	print(punch_damage, " punch damage")
	
	
func punch():
	get_tree().call_group("majin", "punch")
	


func _on_PowerBlock_body_entered(body: Node) -> void:
	state = POWER_ON
	set_process(true)
	print("power_on!")
