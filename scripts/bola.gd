extends CharacterBody2D

@export var init_speed : float = 100
var speed : float
var direction : Vector2
var start_position : bool = false
var dir_adv : bool
var esq_adv : bool

signal gol(lado: int)

func _ready() -> void:
	speed = init_speed
	velocity = Vector2(speed,speed)

func _physics_process(delta: float) -> void:
	
	if (start_position):
		velocity = Vector2.ZERO
		if (dir_adv and Input.is_action_just_pressed("acao_dir")):
			velocity = Vector2(speed,speed)
			start_position = false
			dir_adv = false
		if (esq_adv and Input.is_action_just_pressed("acao_esq")):
			velocity = Vector2(-speed,-speed)
			start_position = false
			esq_adv = false
	
	var col : KinematicCollision2D = move_and_collide(velocity * delta)
	if col:
		#print("test")
		var normal : Vector2 = col.get_normal()
		velocity = velocity.bounce(normal)
		#print(velocity)
		if (col.get_collider().is_in_group("Paddles")):
			velocity.x *= 1.1
			velocity.y += col.get_collider().velocity.y
			velocity.y = clamp(velocity.y, -speed, speed)
			#print("+paddle: ", velocity)

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if (body.is_in_group("GolDir")):
		emit_signal("gol", -1)
		speed = init_speed
		position = Vector2(319,179)
		start_position = true
		dir_adv = true

	if (body.is_in_group("GolEsq")):
		emit_signal("gol", 1)
		speed = init_speed
		position = Vector2(319,179)
		start_position = true
		esq_adv = true
