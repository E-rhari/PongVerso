extends Node

@export var gamemodes: Array[Script]
@export var debug_gamemode : Variant
@onready var speaker = $"../AudioStreamPlayer"
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
	
	#Trocar animações
	if(current_gamemode.get("ball")):
		get_tree().get_first_node_in_group("bola").get_node("BolaAnim2D").sprite_frames = current_gamemode.get("ball")
	if(current_gamemode.get("bg")):
		get_tree().get_first_node_in_group("Background").texture = current_gamemode.get("bg")
	if(current_gamemode.get("paddle")):
			for i in get_tree().get_nodes_in_group("Paddles"):
				i.get_node("Anim2D").sprite_frames = current_gamemode.get("paddle")
	
	#Trocar música
	if (current_gamemode.get("music")):
		speaker.stream = current_gamemode.music
	else:
		speaker.stream = preload("uid://d1nnbf6jfa276")
	speaker.play()


func end_gamemode() -> void:
	current_gamemode.queue_free()
	get_tree().get_first_node_in_group("bola").get_node("BolaAnim2D").sprite_frames = preload("uid://bj2j5bk3e558j")
	get_tree().get_first_node_in_group("Background").texture = preload("uid://dmjrpljo46b35")
	for i in get_tree().get_nodes_in_group("Paddles"):
		i.get_node("Anim2D"). sprite_frames = preload("uid://by0chl6ays0a1")
	
func _on_bola_gol(_lado: int) -> void:
	end_gamemode()
	init_gamemode()
