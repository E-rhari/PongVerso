extends Node2D

var prox_formation := ["res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_1.tscn", "res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_2.tscn"]
@export var formation_index : int = 0
@onready var formation =  prox_formation[formation_index]


var atual_formation : Node = null

func _ready() -> void:
	spawn_formacao()

func _process(_delta: float) -> void:
	if atual_formation and is_instance_valid(atual_formation):
		confere_formacao_atual()

func confere_formacao_atual():
	if not is_instance_valid(atual_formation):
		return

	if atual_formation.get_node("BlockFormationManager").formation_restart:
		formation_index = 1
		formation = prox_formation[formation_index]
		atual_formation.queue_free()
		atual_formation = null
		$SpawnDelay.start()

func _on_spawn_delay_timeout() -> void:
	spawn_formacao()

func spawn_formacao():
	var aux = load(formation)
	atual_formation = aux.instantiate()
	add_child(atual_formation)
