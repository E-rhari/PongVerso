extends Node

# Insira os padrões aqui ->
@onready var patterns : Array[PackedScene] = [preload("uid://oqqo00pq6s30")]
@onready var bola : CharacterBody2D = get_tree().get_first_node_in_group("bola")
@onready var hud : Control = get_tree().get_first_node_in_group("Hud")

#@onready var init_accel = bola.acceleration
@onready var init_scale = bola.scale

func _ready() -> void:
	#bola.acceleration = 1.01
	bola.scale *= 2
	var scene = patterns[randi() % patterns.size()]
	var instance = scene.instantiate()
	add_child.call_deferred(instance)
	bola.disconnect("gol", hud._on_bola_gol)
	bola.connect("gol", _teleportar_bola)

func _teleportar_bola(lado: int) -> void:
	bola.position += Vector2.RIGHT * lado * 600

func _exit_tree() -> void:
	#bola.acceleration = init_accel
	bola.scale = init_scale
