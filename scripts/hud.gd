extends Control

var pontuacao_p1 : int = 0
var pontuacao_p2 : int = 0
var recorde : int = 0
@onready var bola = get_tree().get_first_node_in_group("bola")

func _on_bola_gol(lado: int) -> void:
	recorde = 0
	bola.speed = bola.init_speed
	bola.position = Vector2(322,182)
	bola.start_position = true
	if (lado < 0):
		bola.dir_adv = true
		pontuacao_p1 += 1
		$"Pontuação Jogador 1".text = str(pontuacao_p1)
	else:
		bola.esq_adv = true
		pontuacao_p2 += 1
		$"Pontuação Jogador 2".text = str(pontuacao_p2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rali_toggle"):
		$"Pontuação Jogador 1".visible = !$"Pontuação Jogador 1".visible
		$"Pontuação Jogador 2".visible = !$"Pontuação Jogador 2".visible
		$Recorde.visible = !$Recorde.visible

func _on_bola_bateu_no_paddle() -> void:
	recorde += 1
	$Recorde.text = str(recorde)
