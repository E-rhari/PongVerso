extends CharacterBody2D

@export var speed: float = 100
@export var id: String

func _physics_process(_delta: float) -> void:
	velocity.y = sign(Input.get_axis("up" + id, "down" + id)) * speed
	move_and_slide()
