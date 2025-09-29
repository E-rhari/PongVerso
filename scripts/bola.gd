extends CharacterBody2D

@export var init_speed : float = 100
var speed : float
var direction : Vector2
var start_position : bool = false
var dir_adv : bool
var esq_adv : bool

signal gol(lado: int)
signal bateu_na_parede(onde: Vector2)
signal bateu_no_paddle(lado: int)

func _ready() -> void:
	speed = init_speed
	velocity = Vector2(speed,speed)

func _physics_process(delta: float) -> void:
	
	if (start_position):
		velocity = Vector2.ZERO
		if (dir_adv and Input.is_action_just_pressed("acao1")):
			velocity = Vector2(speed,speed)
			start_position = false
			dir_adv = false
		if (esq_adv and Input.is_action_just_pressed("acao0")):
			velocity = Vector2(-speed,-speed)
			start_position = false
			esq_adv = false
	
	var col : KinematicCollision2D = move_and_collide(velocity * delta)
	if col:
		var normal : Vector2 = col.get_normal()
		velocity = velocity.bounce(normal)
		if (col.get_collider().is_in_group("Paddles")):
			bateu_no_paddle.emit(int(col.get_collider().id))
			speed = clamp(speed * 1.1, 0, 666)
			velocity.y += col.get_collider().get_real_velocity().y
			velocity.y = clamp(velocity.y, -speed, speed)
		velocity.x = sign(velocity.x) * speed
		if (col.get_collider().is_in_group("Paredes")):
			bateu_na_parede.emit(position)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.is_in_group("GolDir")):
		emit_signal("gol", -1)
		
	if (area.is_in_group("GolEsq")):
		emit_signal("gol", 1)
