extends Node

var portal_color : bool = false

func _ready() -> void:
	get_tree().get_first_node_in_group("bola").bateu_na_parede.connect(spawn_portal)

func spawn_portal(onde: Vector2):
	if (get_child_count() >= 2):
		get_children().front().queue_free()
	var scene = preload("uid://0ir3rnxr83ts")
	var instance = scene.instantiate()
	instance.position = onde
	portal_color = !portal_color
	if (portal_color):
		instance.get_child(0).modulate = Color("0065ff")
	add_child(instance)

var music = preload("uid://drn8q3sv3r6dy")
