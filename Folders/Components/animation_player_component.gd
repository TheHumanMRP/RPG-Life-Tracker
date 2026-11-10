class_name AnimationPlayerComponent
extends Node

@export_group("Normal Animations")

@export var idle_animation_name: String = "Idle"
@export var left_animation_name: String = "Left"
@export var right_animation_name: String = "Right"
@export var up_animation_name: String = "Up"
@export var down_animation_name: String = "Down"

@export_group("Up Animations")

@export var up_right_animation_name: String = "up-right"
@export var up_left_animation_name: String = "up-left"

@export_group("Down Animations")

@export var down_right_animation_name: String = "down-right"
@export var down_left_animation_name: String = "down-left"

@export_group("Animation Player")

@export var animation_player: AnimatedSprite2D

func play_animation(velocity: Vector2):
	# Handle Player not moving animations
	if velocity.abs().x < 10:
		if velocity.y == 0:
			_check_and_play_animation_in_animation_player(idle_animation_name)
			return
	
		if velocity.y < 0:
			_check_and_play_animation_in_animation_player(up_animation_name)
			return
		
		if velocity.y > 0:
			_check_and_play_animation_in_animation_player(down_animation_name)
			return

	# Handle Right Animations
	if velocity.x > 10:
		# Player not falling nor going up
		if velocity.y == 0:
			_check_and_play_animation_in_animation_player(right_animation_name)
			return

		# Player falling
		if velocity.y > 0:
			_check_and_play_animation_in_animation_player(down_right_animation_name)
			return
		
		# Player going up
		if velocity.y < 0:
			_check_and_play_animation_in_animation_player(up_right_animation_name)
			return

	# Handle Left Animations
	if velocity.x < 10:
		# PLayer not falling nor going up
		if velocity.y == 0:
			_check_and_play_animation_in_animation_player(left_animation_name)
			return
		
		# Player falling
		if velocity.y > 0:
			_check_and_play_animation_in_animation_player(down_left_animation_name)
			return
		
		# Player going up
		if velocity.y < 0:
			_check_and_play_animation_in_animation_player(up_left_animation_name)
			return

func _check_and_play_animation_in_animation_player(animation_name: String) -> void:
	if not animation_player.sprite_frames.has_animation(animation_name):
		push_error("No animation named: ", animation_name)
		return
	
	animation_player.play(animation_name)