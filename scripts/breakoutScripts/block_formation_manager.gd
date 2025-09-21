extends Node

@export var atual_formation_blocks : Node2D

var qtd_blocos : int = 0
var formation_restart : bool = false

func _ready() -> void:
	conta_blocos()


func _process(_delta: float) -> void:
	pass


func conta_blocos():
	for blocos in atual_formation_blocks.get_children():
		qtd_blocos += 1

func atualiza_blocos():
	qtd_blocos -= 1
	if(qtd_blocos <= 0):
		formation_restart = true
