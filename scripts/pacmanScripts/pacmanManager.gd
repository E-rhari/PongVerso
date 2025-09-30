extends Node

# Insira os padrões aqui ->
@onready var patterns : Array[PackedScene] = [preload("uid://oqqo00pq6s30")]
@onready var bola : CharacterBody2D = get_tree().get_first_node_in_group("bola")
@onready var hud : Control = get_tree().get_first_node_in_group("Hud")
@onready var paddles = get_tree().get_nodes_in_group("Paddles")
@onready var background = get_tree().get_first_node_in_group("Background")

@onready var init_accel = bola.acceleration
@onready var init_scale = bola.scale

var score_p : Array[int] = [0, 0]
var ball_owner = null
var ball_colors : Array[Color] = [Color("61a2ff") , Color("db41c3")]
var pellet_amount : int

func _ready() -> void:
	background.modulate = Color(1, 1, 1, .25)
	for i in paddles:
		i.get_node("Anim2D").sprite_frames = preload("uid://c7ligskuv0d15")
		i.get_node("Anim2D").frame = int(i.id)
	hud.get_node("Pontuação Menor 1").visible = true
	hud.get_node("Pontuação Menor 2").visible = true
	bola.connect("bateu_no_paddle", _switch_owner)
	bola.acceleration = 1.03
	bola.modulate = Color.YELLOW
	bola.get_node("BolaColisao").scale *= 2
	bola.get_node("Area2D").scale *= 2
	var scene = patterns[randi() % patterns.size()]
	var instance = scene.instantiate()
	pellet_amount = instance.get_child_count()
	add_child.call_deferred(instance)
	bola.disconnect("gol", hud._on_bola_gol)
	bola.disconnect("gol", get_parent()._on_bola_gol)
	bola.connect("gol", _teleportar_bola)
	await get_tree().process_frame
	bola.get_node("BolaAnim2D").play()
	background.play()

func _teleportar_bola(lado: int) -> void:
	bola.position += Vector2.RIGHT * lado * 620

func _switch_owner(lado: int):
	if (ball_owner != lado): background.speed_scale *= -1
	ball_owner = lado
	bola.modulate = ball_colors[ball_owner]
	background.modulate *= ball_colors[ball_owner]

func _exit_tree() -> void:
	bola.acceleration = init_accel
	bola.scale = init_scale
	bola.modulate = Color.WHITE
	bola.rotation = 0
	background.modulate = Color.WHITE
	bola.get_node("BolaColisao").scale /= 2
	bola.get_node("Area2D").scale /= 2
	bola.connect("gol", get_parent()._on_bola_gol)
	bola.connect("gol", hud._on_bola_gol)
	hud.get_node("Pontuação Menor 1").visible = false
	hud.get_node("Pontuação Menor 2").visible = false
	hud.get_node("Pontuação Menor 1").text = "0"
	hud.get_node("Pontuação Menor 2").text = "0"

func _process(_delta: float) -> void:
	bola.rotation = bola.velocity.angle()

var ball = preload("uid://saot38re8e2q")
var bg = preload("uid://m1h1mhqw6m4q")
var music = preload("uid://davlmvsfsx2yw")
