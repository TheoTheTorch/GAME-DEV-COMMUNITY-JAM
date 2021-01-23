extends Position2D

onready var bullet_resource = preload("res://Bullet/Bullet.tscn")
onready var ShootPos = get_node("ShootPos")
onready var TimeBtwShot = get_node("TimeBtwShot")
var can_shoot: bool = true

func _physics_process(_delta):
	rotation += get_local_mouse_position().angle()
	
#	# Shoot Trigger
#	if Input.is_action_just_pressed("ctr_mouse"):
#		TimeBtwShot.start()
#	elif Input.is_action_pressed("ctr_mouse"):
#		if can_shoot == true:
#			spawn_bullet()
#			can_shoot = false
#	elif Input.is_action_just_released("ctr_mouse"):
#		TimeBtwShot.stop()
#		can_shoot = true
func _on_TimeBtwShot_timeout():
#	can_shoot = true
	spawn_bullet()


func spawn_bullet():
	var bullet = bullet_resource.instance()
	bullet.position = ShootPos.global_position
	bullet.rotation = rotation
	get_node("/root").get_child(1).add_child(bullet)


