extends Node

func _ready() -> void:
	get_tree().get_first_node_in_group("bola").bateu_na_parede.connect(spawn_portal)

func spawn_portal(onde: Vector2):
	if (get_child_count() >= 2):
		get_children().front().queue_free()
	var scene = preload("uid://0ir3rnxr83ts")
	var instance = scene.instantiate()
	instance.position = onde
	add_child(instance)
	
