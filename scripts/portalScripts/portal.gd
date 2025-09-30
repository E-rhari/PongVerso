extends Area2D

var enabled: bool = false
var vezes_usado: int = 0

@onready var bola = get_tree().get_first_node_in_group("bola")

## Isso mata os portais por tempo. A solução atual é morte após o primeiro TP.
#func _ready() -> void:
	#await get_tree().create_timer(5).timeout
	#queue_free()

func _ready() -> void:
	$AnimatedSprite2D.play()

func _process(_delta: float) -> void:
	if(position.x < bola.position.x): $AnimatedSprite2D.flip_h = false
	else: $AnimatedSprite2D.flip_h = true

func _on_body_entered(body: Node2D) -> void:
	if !(body.is_in_group("bola")): return
	vezes_usado += 1
	if (not enabled):
		enabled = true
		return
	for portal in get_tree().get_nodes_in_group("Portais"):
		if portal != self:
			body.position = portal.position
			portal.enabled = false
	if (vezes_usado >= 3): queue_free()
