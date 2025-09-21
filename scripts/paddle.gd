extends CharacterBody2D

@export var speed: float = 100
@export var id: String

func _physics_process(delta: float) -> void:
	velocity.y = Input.get_axis("up" + id, "down" + id) * speed
	move_and_slide()
