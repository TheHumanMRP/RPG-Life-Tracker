class_name MainNode
extends Node2D

func _ready() -> void:
    self.add_to_group("main")

func switch_to_scene(myself: Node, new_scene: Node) -> void:
    if self.get_children().has(myself):
        self.remove_child(myself)
    
    add_child(new_scene)