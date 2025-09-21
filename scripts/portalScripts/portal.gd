extends Area2D

var enabled: bool = false

func _on_body_entered(body: Node2D) -> void:
	if !(body.is_in_group("bola")): return
	if (not enabled):
		enabled = true
		return
	for portal in get_tree().get_nodes_in_group("Portais"):
		if portal != self:
			body.position = portal.position
			portal.enabled = false
