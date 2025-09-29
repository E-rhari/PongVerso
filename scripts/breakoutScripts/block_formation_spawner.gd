extends Node

var prox_formation := [
	"res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_1.tscn",
	"res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_2.tscn",
	"res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_3.tscn",
	"res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_4.tscn",
	"res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_5.tscn",
	"res://scenes/BreakoutVerso/FormacoesDeBlocos/formacao_de_bloco_6.tscn"
]
@export var formation_index : int = randi_range(0, len(prox_formation)-1)
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
		var manager = atual_formation.get_node("BlockFormationManager")
		if manager.formation_restart:
			# Desativa o sinalizador antes de iniciar o spawn da próxima
			manager.formation_restart = false
		
			# Muda a formação
			formation_index = randi_range(0, len(prox_formation)-1)
			formation = prox_formation[formation_index]

			# Remove a formação atual
			atual_formation.queue_free()
			atual_formation = null

			# Inicia o delay
			await get_tree().create_timer(2).timeout
			spawn_formacao()

func spawn_formacao():
	var aux = load(formation)
	atual_formation = aux.instantiate()
	add_child.call_deferred(atual_formation)
