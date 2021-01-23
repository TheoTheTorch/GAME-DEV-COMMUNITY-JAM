extends Node

# Getting the Player node
onready var player = get_node("/root").find_node("Player", true, false)
var enemy_count: int = 0
var wave_count: int = 0
