extends CharacterBody2D

@onready var health_component: HealthComponent = HealthComponent.new()

func _ready() -> void:
	health_component.died.connect(_on_died)
	self.add_to_group("enemies")

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)

func _on_died() -> void:
	print("Enemy: I died")
	self.queue_free()