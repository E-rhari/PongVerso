extends Area2D

@onready var manager = get_parent().get_parent()

func _on_body_entered(body: Node2D) -> void:
	if (manager.ball_owner == null): return
	if (body.is_in_group("bola")):
		manager.score_p[manager.ball_owner] += 1
		queue_free()
