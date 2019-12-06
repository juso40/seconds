extends Node2D

const MAIN_MENU = "res://MainMenu.tscn"

var current_map

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show_map(MAIN_MENU)
	# get_tree().change_scene("res://MainMenu.tscn")

func show_map(map_name):
	if self.current_map != null:
		self.current_map.queue_free()
	self.current_map = load(map_name).instance()
	self.add_child(self.current_map)
