extends StaticBody2D

@export var formacao_atual_de_blocos : Node2D

@export var vida_do_bloco : int = 3

# Cores
@export var branco : Color
@export var rosa : Color
@export var vermelho : Color

func _on_area_2d_body_entered(body: Node2D) -> void:
	# Retira "vida" do bloco com a colisão com a bola
	if (body.is_in_group("bola")):
		vida_do_bloco -= 1
	
	# Remove o bloco caso sua vida chegue a zero
	if (vida_do_bloco <= 0):
			formacao_atual_de_blocos.atualiza_blocos()
			queue_free()
	
	altera_cor()

# Função que altera a cor do bloco a cada vez que ele toma hit da bola
func altera_cor():
	$Sprite2D.frame = 3 - vida_do_bloco
	if (vida_do_bloco == 3):
		modulate = branco
	elif (vida_do_bloco == 2):
		modulate = rosa
	elif (vida_do_bloco == 1):
		modulate = vermelho
	elif (vida_do_bloco < 0):
		print("Block 'altera_cor' error")
