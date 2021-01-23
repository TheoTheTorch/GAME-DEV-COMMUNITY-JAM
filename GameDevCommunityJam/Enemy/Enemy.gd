extends KinematicBody2D

var velocity := Vector2(0,0)
var intention := Vector2(0,0)
export(int) var max_speed := 160
export(int) var acceleration := 240
export(int) var target_distance := 25
export(int) var hazard_distance := 60
# To not jam up with other enemies:
var bodies : Array = []
# Global
onready var global = get_node("/root/Global")
# Health
export(int) var max_health := 2
var health: int = max_health


func  _ready():
	add_to_group("Enemy")
	$Hitbox.add_to_group("Enemy")


func _physics_process(delta):
	#Affecting intentions
	push_towards_player()
	for body in bodies:
		push_away_from_objects(body)
	# Actual moving
	velocity = intention * acceleration * delta
	velocity = velocity.clamped(max_speed)
	velocity = move_and_slide(velocity, Vector2.UP)
	# Iportant to reset the velocity AT THE END 
	# So the eneys aren't slippery
	intention = Vector2(0,0)


func push_towards_player():
	var player_pos = global.player.global_position
	var player_distance = global_position.distance_to(player_pos)
	var player_dir = (player_pos - global_position).normalized()
	
	
	var string_force = (player_distance - target_distance)
	intention += string_force * player_dir


func push_away_from_objects(body):
	var body_pos = body.global_position
	var body_distance = global_position.distance_to(body_pos)
	var body_dir = body_pos.direction_to(global_position).normalized()
	
	var string_force = 1.0 / (1.0 + body_distance * body_distance * body_distance)
	intention -= string_force * body_dir


func _on_Reciever_area_entered(area):
	if area.get_parent().is_in_group("Enemy"):
		bodies.append(area.get_parent())
func _on_Reciever_area_exited(area):
	if area.get_parent() in bodies:
		bodies.remove(bodies.find(area.get_parent()))


func damage(dmg: int):
	health -= dmg
	if health <= 0:
		global.enemy_count -= 1
		get_tree().call_group("WaveCtr", "should_spawn_next_wave")
		queue_free() # replace with animation


