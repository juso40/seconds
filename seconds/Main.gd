extends Node2D

export (PackedScene) var Map


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Player._init()


func _process(delta):
	pass
