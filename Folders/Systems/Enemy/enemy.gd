extends CharacterBody2D

@onready var health_component: HealthComponent = HealthComponent.new()

func _ready() -> void:
	health_component.died.connect(_on_died)
	self.add_to_group("enemies")

func _on_died() -> void:
	print("Enemy: I died")
	self.queue_free()