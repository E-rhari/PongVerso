class_name StateMachine extends Node

@export var initial_state : States = null

@onready var state : States = (func get_initial_state() -> States: 
	return initial_state if initial_state != null else get_child(0)
	).call()


func _ready() -> void:
	for state_node : States in find_children("*", "States"):
		state_node.finished.connect(_state_change_transition)
	
	await owner.ready
	state.enter("")


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _state_change_transition(target_state_path : String):
	# Debug
	if not has_node(target_state_path):
		printerr(owner.name + ": Tentou transitar para o estado " + target_state_path + " mas o estado não existe.")
		return
	
	# Mudança de estado
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path)
