extends CharacterBody2D

var speed: float = 100
const jump_speed: float = -760
const deceleration = 0.1
var id: String
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_floor: bool

func _physics_process(delta: float) -> void:
	
	if !(on_floor):
		velocity.y += gravity * delta
	
	if (Input.is_action_just_pressed("up" + id) and on_floor):
		velocity.y = jump_speed
	
	if (Input.is_action_just_released("up" + id) and velocity.y < 0):
		velocity.y *= deceleration
	
	on_floor = false
	for i in get_slide_collision_count():
		if (get_slide_collision(i).get_collider().name == "Chão"):
			on_floor = true
	
	move_and_slide()

var music = preload("uid://dv5gshfopqhdy")
