extends CharacterBody2D

@export var speed: float = 100
@export var id: String

const dash_distance: float = 100
const dash_time: float = 0.08
const dash_cooldown: float = 1.5

var can_dash: bool = true
var is_dashing: bool = false
var dash_vector: Vector2 = Vector2.ZERO
var distance_traveled: float = 0

var trilho : AnimatedSprite2D
var anim_time : float = 20

func _init() -> void:
	set_process(true)
	trilho = AnimatedSprite2D.new()
	trilho.sprite_frames = preload("uid://dy7k6o8y7165g")
	trilho.position = Vector2(position.x, 180)
	trilho.z_index = -1
	$"../Manager".get_child(0).add_child(trilho)

func _process(delta: float) -> void:
	$Anim2D.frame = not can_dash
	var vel = get_real_velocity().y / speed
	anim_time += delta * vel * 20
	var frames = trilho.sprite_frames.get_frame_count(trilho.animation)
	trilho.frame = int(anim_time) % frames
	
	#trilho.sprite_frames.set_animation_speed("default", velocity.y)

func _physics_process(delta: float) -> void:
	
	if (is_dashing):
		velocity = dash_vector
		move_and_slide()
		
		distance_traveled += velocity.length() * delta
		
		if (get_slide_collision_count() > 0 or distance_traveled >= dash_distance):
			stop_dash()
	
	else:
		var move_input: float = Input.get_axis("up" + id, "down" + id)
		velocity.y = Input.get_axis("up" + id, "down" + id) * speed
		move_and_slide()
		
		if (Input.is_action_just_pressed("acao" + id) and can_dash and move_input != 0):
			start_dash(Input.get_axis("up" + id, "down" + id))

func start_dash(direction: float):
	can_dash = false
	is_dashing = true
	distance_traveled = 0
	
	var dash_speed = dash_distance / dash_time
	dash_vector = Vector2(0, direction * dash_speed)
	
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true

func stop_dash():
	is_dashing = false
	velocity = Vector2.ZERO
