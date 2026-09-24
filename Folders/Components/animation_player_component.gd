class_name AnimationPlayerComponent
extends Node

@export_group("Normal")

@export var idle_animation_name: String = "Idle"
@export var left_animation_name: String = "Left"
@export var right_animation_name: String = "Right"
@export var up_animation_name: String = "Up"
@export var down_animation_name: String = "Down"

@export_group("Up")

@export var up_right_animation_name: String = "up-right"
@export var up_left_animation_name: String = "up-left"

@expo

@export var down_right_animation_name: String = "down-right"
@export var down_left_animation_name: String = "down-left"

@export var animation_player: AnimationPlayer

