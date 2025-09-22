extends Node

@export var gamemodes: Array[Script]
@export var debug_gamemode : Variant
var current_gamemode: Node

func _ready() -> void:
	init_gamemode()

func init_gamemode() -> void:
	var game = Node.new()
	if(debug_gamemode):
		game.set_script(gamemodes[debug_gamemode])
		get_tree().get_first_node_in_group("bola").disconnect("gol", _on_bola_gol)
	else:
		game.set_script(gamemodes[randi() % gamemodes.size()])
	current_gamemode = game
	add_child(game)

func end_gamemode() -> void:
	current_gamemode.queue_free()
	
func _on_bola_gol(_lado: int) -> void:
	end_gamemode()
	init_gamemode()
