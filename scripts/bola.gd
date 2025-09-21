extends CharacterBody2D


@export var speed : float = 100.0
var direction : Vector2
var start_position : bool = false
var dir_adv : bool
var esq_adv : bool

func _ready() -> void:
	direction = Vector2(1,1)

func _physics_process(_delta: float) -> void:
	if (start_position):
		direction = Vector2.ZERO
		if (dir_adv and Input.is_action_just_pressed("acao_dir")):
			direction = Vector2(1,1)
			start_position = false
			dir_adv = false
		if (esq_adv and Input.is_action_just_pressed("acao_esq")):
			direction = Vector2(1,1)
			start_position = false
			esq_adv = false
	velocity = direction * speed
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Paddles")):
		direction.x *= -1
		speed += 10

	if (body.is_in_group("Paredes")):
		direction.y *= -1

	if (body.is_in_group("GolDir")):
		speed = 100.0
		position = Vector2(319,179)
		start_position = true
		dir_adv = true

	if (body.is_in_group("GolEsq")):
		speed = 100.0
		position = Vector2(319,179)
		start_position = true
		esq_adv = true
