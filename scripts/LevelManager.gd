extends Node

@export var gamemodes: Array[Script]
@export var debug_gamemode : Variant
@export var start_on_pong : bool = true
@onready var speaker = $"../AudioStreamPlayer"
var current_gamemode: Node
var current_index: int
var last_index: int

func _ready() -> void:
	if (not start_on_pong or debug_gamemode): init_gamemode()

func init_gamemode() -> void:
	
	var game = Node.new()
	if(debug_gamemode):
		game.set_script(gamemodes[debug_gamemode])
		get_tree().get_first_node_in_group("bola").disconnect("gol", _on_bola_gol)
	else:
		current_index = randi() % gamemodes.size()
		while(current_index == last_index):
			current_index = randi() % gamemodes.size()
		last_index = current_index
		game.set_script(gamemodes[current_index])
	current_gamemode = game
	add_child(game)
	
	#Trocar animações
	if(current_gamemode.get("ball")):
		get_tree().get_first_node_in_group("bola").get_node("BolaAnim2D").sprite_frames = current_gamemode.get("ball")
	if(current_gamemode.get("bg")):
		get_tree().get_first_node_in_group("Background").sprite_frames = current_gamemode.get("bg")
	if(current_gamemode.get("paddle")):
			for i in get_tree().get_nodes_in_group("Paddles"):
				i.get_node("Anim2D").sprite_frames = current_gamemode.get("paddle")
	
	#Trocar música
	if (current_gamemode.get("music")):
		speaker.stream = current_gamemode.music
	else:
		speaker.stream = preload("uid://c6b5o405dmxxl")
	speaker.play()


func end_gamemode() -> void:
	if(current_gamemode): current_gamemode.queue_free()
	get_tree().get_first_node_in_group("bola").get_node("BolaAnim2D").sprite_frames = preload("uid://bj2j5bk3e558j")
	get_tree().get_first_node_in_group("Background").sprite_frames = preload("uid://dq81bj50eno53")
	for i in get_tree().get_nodes_in_group("Paddles"):
		i.get_node("Anim2D"). sprite_frames = preload("uid://by0chl6ays0a1")
	
func _on_bola_gol(_lado: int) -> void:
	end_gamemode()
	await get_tree().process_frame
	init_gamemode()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_home")):
		if (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
