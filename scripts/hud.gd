extends Control

var pontuacao_p1 : int = 0
var pontuacao_p2 : int = 0
var recorde : int = 0

func _on_bola_gol(lado: int) -> void:
	recorde = 0
	if (lado < 0):
		pontuacao_p1 += 1
		$"Pontuação Jogador 1".text = str(pontuacao_p1)
	else:
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
