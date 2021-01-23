extends Node2D

onready var enemy_recource = preload("res://Enemy/Enemy.tscn")
onready var global = get_node("/root/Global")
var spawn_box_start := Vector2(0,0)
onready var spawn_box_end : Vector2 = get_viewport_rect().size
onready var WaveDisplay = get_node("CanvasLayer/CenterContainer/VBoxContainer/WaveDisplay")

export(float) var spawn_multiplyer := 0.9
export(int) var spawn_offset := 4

func _ready() -> void:
	randomize()
	add_to_group("WaveCtr")
	next_wave()

func should_spawn_next_wave() -> void:
	if global.enemy_count <= 0:
		next_wave()

func next_wave() -> void:
	global.wave_count += 1
	WaveDisplay.text = "Wave " + str(global.wave_count)
	spawn_enemies()

func spawn_enemies() -> void:
	var spawn_numb: int = spawn_offset + round(global.wave_count * (spawn_multiplyer * spawn_multiplyer))
	for i in range(spawn_numb):
		var enemy = enemy_recource.instance()
		enemy.global_position = Vector2(rand_range(spawn_box_start.x, spawn_box_end.x), 
										rand_range(spawn_box_start.y, spawn_box_end.y))
		add_child(enemy)
		
		global.enemy_count = spawn_numb

