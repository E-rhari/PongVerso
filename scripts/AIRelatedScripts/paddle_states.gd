class_name PaddleAIStates extends States

const CHASE : String = "Chase"

var paddle : PaddleAI

func _ready() -> void:
	await owner.ready
	paddle = owner as PaddleAI
	assert(paddle != null, "O PaddleStates deve ser usado apenas na cena do Paddle AI. O dono deve ser da classe PaddleAI.")
