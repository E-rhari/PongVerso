extends Node

@onready var paddles = get_tree().get_nodes_in_group("Paddles")

func _ready() -> void:
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://bhbr7m2ifhx1v"))
		paddles[i].id = str(i)
		paddles[i].speed = spd
	
	#var scene = preload("uid://c6mx8q70ruj0p")
	#while(true):
		#await get_tree().create_timer(4).timeout
		#var instance = scene.instantiate()
		#add_child(instance)

func _exit_tree() -> void:
	for i in paddles.size():
		var spd: int = paddles[i].speed
		paddles[i].set_script(preload("uid://ch8cxp6qaubio"))
		paddles[i].id = str(i)
		paddles[i].speed = spd

var music = preload("uid://dv5gshfopqhdy")
