class_name AnimationComponent
extends Node

@export var animated_sprite_2d: AnimatedSprite2D

@export var idle_animation_name = "Idle"

@export var moving_left_animation_name = "Moving-Left"
@export var moving_right_animation_name = "Moving-Right"

@export var moving_up_animation_name = "Moving-Up"
@export var moving_up_left_animation_name = "Moving-Up-Left"
@export var moving_up_right_animation_name = "Moving-Up-Right"

@export var moving_down_animation_name = "Moving-Down"
@export var moving_down_left_animation_name = "Moving-Down-Left"
@export var moving_down_right_animation_name = "Moving-Down-Right"

func _ready() -> void:
	if not animated_sprite_2d:
		push_error("Brother, you forgot to assaign animation_player to one of the animation componenet")
		return
	
	animated_sprite_2d.play("Idle")

func play_animation(velocity: Vector2) -> void:
	if velocity == Vector2.ZERO:
		animated_sprite_2d.play(idle_animation_name)
		return

	var x := signi(int(velocity.x))
	var y := signi(int(velocity.y))

	match Vector2i(x, y):
		Vector2i(-1, 0): animated_sprite_2d.play(moving_left_animation_name)
		Vector2i(1, 0): animated_sprite_2d.play(moving_right_animation_name)
		
		Vector2i(0, -1): animated_sprite_2d.play(moving_up_animation_name)
		Vector2i(-1, -1): animated_sprite_2d.play(moving_up_left_animation_name)
		Vector2i(1, -1): animated_sprite_2d.play(moving_up_right_animation_name)

		Vector2i(0, 1): animated_sprite_2d.play(moving_down_animation_name)
		Vector2i(-1, 1): animated_sprite_2d.play(moving_down_left_animation_name)
		Vector2i(1, 1): animated_sprite_2d.play(moving_down_right_animation_name)
