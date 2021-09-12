extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

export var speed := 600

export var jump_pow := 1100.0

export var gravity := 4500.0

var _velocity := Vector2.ZERO
var _h_direction := 0.0


func _process(delta: float) -> void:
	movement(delta)

	move_and_slide(_velocity)

func movement(delta: float) -> void:
	_h_direction = (
		Input.get_action_strength('right_move')
		- Input.get_action_strength('left_move')
	)
	
	_velocity.x = _h_direction * speed
	_velocity.y += gravity * delta
	
	if is_jumping():
		_velocity.y = -jump_pow
		
	
func is_block_push() -> void:
	_velocity.y = jump_pow
	


func is_jumping() -> bool:
	return Input.is_action_just_pressed('jump') 
