extends CharacterBody2D


@export var speed : float = 100.0
var direction : Vector2 = Vector2(1,1)

func _ready() -> void:
	direction = Vector2(1,1)

func _physics_process(_delta: float) -> void:
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
	
	if (body.is_in_group("GolEsq")):
		speed = 100.0
		position = Vector2(319,179)
