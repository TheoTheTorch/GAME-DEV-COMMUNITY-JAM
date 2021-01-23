extends Area2D

var velocity := Vector2(0,0)
export(int) var speed = 360
export(int) var dmg = 1

func _physics_process(delta):
#	var direction = Vector2().angle()
	velocity = Vector2(1,0).rotated(rotation) * speed * delta
	
	position += velocity

func _on_Bullet_area_entered(area):
	if area.get_parent().is_in_group("Enemy"):
		area.get_parent().damage(dmg)
		queue_free()



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
