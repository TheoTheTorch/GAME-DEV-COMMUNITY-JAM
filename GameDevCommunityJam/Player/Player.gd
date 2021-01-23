extends KinematicBody2D

#Movement
var velocity : Vector2 = Vector2(0,0)
export(int) var acceleration = 2000
export(int) var max_speed = 360
export(int) var friction = 1600

func _ready():
	add_to_group("Player")


func _physics_process(delta: float):
	movement(delta)
	
	velocity = move_and_slide(velocity, Vector2.UP)

func movement(delta: float) -> void:
	var dir := Vector2(0,0)
	dir.x = int(Input.is_action_pressed("ctr_right")) - int(Input.is_action_pressed("ctr_left"))
	dir.y = int(Input.is_action_pressed("ctr_down")) - int(Input.is_action_pressed("ctr_up"))
	dir = dir.normalized()
	
	if dir != Vector2(0,0):
		velocity += dir * acceleration * delta
		velocity = velocity.clamped(max_speed)
	else:
		velocity = velocity.move_toward(Vector2(0,0), friction * delta)

