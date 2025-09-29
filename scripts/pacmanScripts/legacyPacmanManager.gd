extends Node

const lines_amount: int = 10
const pellet_amount: int = 8
const offset: float = 30
const screen_size: Vector2 = Vector2(640, 360)
const padding: float = .2
@onready var top_left: Vector2 = screen_size * padding
@onready var down_right: Vector2 = screen_size * (1 - padding)
const straight_angles: Array[Vector2] = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func _ready() -> void:
	var scene = preload("uid://bvt87phnnvjg6")
	var last_pos: Vector2
	var last_angle: Vector2
	for i in lines_amount:
		var init_pos: Vector2 = Vector2(randf_range(top_left.x, down_right.x), randf_range(top_left.y, down_right.y))
		if (last_pos): init_pos = last_pos
		var angle = generate_angle(last_angle)
		for j in pellet_amount:
			var instance = scene.instantiate()
			var next_pos = init_pos + angle * j * offset
			if (next_pos.clamp(top_left, down_right) != next_pos):
				print("morte")
				instance.queue_free()
				break
			instance.position = next_pos
			last_pos = next_pos
			last_angle = angle
			print("iteration: ", i, ":", j, " ,pos = ", last_pos)
			add_child(instance)

func generate_angle(last_angle: Vector2) -> Vector2:
	if !(last_angle): return straight_angles[randi() % 4]
	var angle: Vector2 = -last_angle
	while (angle == -last_angle):
		angle = straight_angles[randi() % 4]
	return angle
	
