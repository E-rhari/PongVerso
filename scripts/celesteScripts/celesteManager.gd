extends Node

@onready var paddles = get_tree().get_nodes_in_group("Paddles")
@onready var bola = get_tree().get_first_node_in_group("bola")
@onready var init_accel = bola.acceleration

func _ready() -> void:
	bola.acceleration = 1.1
	
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://b1e4vnoi65guu"))
		paddles[i].id = str(i)
		paddles[i].speed = spd
	
	await get_tree().process_frame
	get_tree().get_first_node_in_group("bola").get_node("BolaAnim2D").play()

func _exit_tree() -> void:
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://ch8cxp6qaubio"))
		paddles[i].id = str(i)
		paddles[i].speed = spd

var music = preload("uid://bwolqsuw8n872")
var ball = preload("uid://7wqrdrg1an12")
var paddle = preload("uid://7mvrhekto7s2")
var bg = preload("uid://3tnuw4u4t8kf")
