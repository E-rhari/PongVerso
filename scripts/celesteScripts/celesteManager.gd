extends Node

@onready var paddles = get_tree().get_nodes_in_group("Paddles")

func _ready() -> void:
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://b1e4vnoi65guu"))
		paddles[i].id = str(i)
		paddles[i].speed = spd

func _exit_tree() -> void:
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://ch8cxp6qaubio"))
		paddles[i].id = str(i)
		paddles[i].speed = spd
