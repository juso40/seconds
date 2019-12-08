extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD.show()
	$HUD.show_message("Go!")

func _process(delta):
	if $Player.position.y >= 200:
		$HUD.show_message("You Died!")
		var t = Timer.new()
		t.set_wait_time(0.75)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		get_tree().change_scene("res://scenes/menumap/MainMenu.tscn")
		t.queue_free()
