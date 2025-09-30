extends Node

var portal_color : bool = false
@onready var bola = get_tree().get_first_node_in_group("bola")

func _ready() -> void:
	bola.bateu_na_parede.connect(spawn_portal)
	for i in get_tree().get_nodes_in_group("Paddles"):
		i.get_node("Anim2D").sprite_frames = preload("uid://jw2x70mrha7j")
		i.get_node("Anim2D").frame = int(i.id)

func _process(delta: float) -> void:
	bola.rotation += delta * 10

func _exit_tree() -> void:
	bola.rotation = 0

func spawn_portal(onde: Vector2):
	if (get_child_count() >= 2):
		get_children().front().queue_free()
	var scene = preload("uid://0ir3rnxr83ts")
	var instance = scene.instantiate()
	onde = onde + Vector2.UP * 25 if(onde.y > 180) else onde + Vector2.DOWN * 25
	onde = Vector2(roundf((onde.x - 108.0) / 31) * 31 + 108, onde.y)
	instance.position = onde
	portal_color = !portal_color
	if (portal_color):
		instance.get_node("AnimatedSprite2D").sprite_frames = preload("uid://cbxfhhpfeogb7")
	add_child(instance)

var music = preload("uid://drn8q3sv3r6dy")
var bg = preload("uid://dkn6o0fgnee05")
var ball = preload("uid://bnces1mfywg5t")
