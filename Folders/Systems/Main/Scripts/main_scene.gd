extends Node2D

func switch_to_scene(myself: Node, new_scene: Node) -> void:
    if self.get_children().has(myself):
        