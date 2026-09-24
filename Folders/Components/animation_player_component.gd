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
	# Handle Player Standing Still
	if velocity.abs().x < 10 and velocity.abs().y == 0:
		animation_player.play(idle_animation_name)
		return
	
	# Handle Right Animations
	if velocity.x > 10:
		# Player not falling nor going up
		if velocity.y == 0:
			animation_player.play(right_animation_name)
			return

		# Player falling
		if velocity.y > 0:
			animation_player.play(down_right_animation_name)
			return
		
		# Player going up
		if velocity.y < 0:
			animation_player.play(up_right_animation_name)
			return

	# Handle Left Animations
	if velocity.x < 10:
		# PLayer not falling nor going up
		if velocity.y == 0:
			animation_player.play(left_animation_name)
			return
		
		# Player falling
		if velocity.y > 0:
			animation_player.play(down_left_animation_name)
			return
		
		# Player going up
		if velocity.y < 0:
			animation_player.play(up_left_animation_name)
			return