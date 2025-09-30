extends Node

@onready var paddles = get_tree().get_nodes_in_group("Paddles")
@onready var bola = get_tree().get_first_node_in_group("bola")

func _ready() -> void:
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://bhbr7m2ifhx1v"))
		paddles[i].id = str(i)
		paddles[i].speed = spd

func _process(delta: float) -> void:
	bola.get_node("BolaAnim2D").rotation += delta * bola.speed * .05

func _exit_tree() -> void:
	bola.get_node("BolaAnim2D").rotation = 0
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://ch8cxp6qaubio"))
		paddles[i].id = str(i)
		paddles[i].speed = spd

var music = preload("uid://dv5gshfopqhdy")
var ball = preload("uid://c0yikrqbdeeth")
var bg = preload("uid://b3x14oxkhkq2l")
var paddle = preload("uid://b32fmduwdt44q")
