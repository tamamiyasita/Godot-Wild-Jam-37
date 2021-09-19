extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed := 270

export var jump_pow := 630.0

export var gravity := 2100.0


onready var sprite : Sprite = $Sprite
onready var anime : AnimationPlayer = $AnimationPlayer

var _velocity := Vector2.ZERO
var _h_direction := 0.0


func _process(delta: float) -> void:
	movement(delta)

	move_and_slide(_velocity, UP_DIRECTION)

func movement(delta: float) -> void:
	_h_direction = (
		Input.get_action_strength('right_move')
		- Input.get_action_strength('left_move')
	)
	
	_velocity.x = _h_direction * speed
	_velocity.y += gravity * delta
	if _velocity.x > 0:
		sprite.flip_h = false
	if _velocity.x < 0:
		sprite.flip_h = true
#		$Run.play()
	
	if abs(_velocity.x) == 0 and is_on_floor():
		anime.play('default')
	if is_jumping():
		$AudioStreamPlayer.play()
		_velocity.y = -jump_pow
		anime.play('jump')
		
		
	elif abs(_velocity.x) > 0 and !anime.current_animation == "jump":
		anime.play('move')	

	
func sit() -> void:
	anime.play('sit')


func is_block_push() -> void:
	_velocity.y = jump_pow
	


func is_jumping() -> bool:
	return Input.is_action_just_pressed('jump') and is_on_floor()
