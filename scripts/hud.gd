extends Control

var pontuacao_p1 : int = 0
var pontuacao_p2 : int = 0

func _on_bola_gol(lado: int) -> void:
	if (lado < 0):
		pontuacao_p1 += 1
		$"Pontuação Jogador 1".text = str(pontuacao_p1)
	else:
		pontuacao_p2 += 1
		$"Pontuação Jogador 2".text = str(pontuacao_p2)
