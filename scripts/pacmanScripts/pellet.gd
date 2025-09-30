extends Area2D

@onready var manager = get_parent().get_parent()
@onready var hud = get_tree().get_first_node_in_group("Hud")

func _on_body_entered(body: Node2D) -> void:
	if (manager.ball_owner == null): return
	if (body.is_in_group("bola")):
		manager.score_p[manager.ball_owner] += 1
		hud.get_node("Pontuação Menor " + str(manager.ball_owner + 1)).text = str(manager.score_p[manager.ball_owner] * 10)
		if (manager.score_p.max() > manager.pellet_amount/2):
			manager.get_parent()._on_bola_gol(0)
			hud._on_bola_gol(2 * manager.score_p.find(manager.score_p.max()) - 1)
		queue_free()
