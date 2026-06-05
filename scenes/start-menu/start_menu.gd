extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_newGame_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main-menu/main-menu.tscn")

func _on_loadGame_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main-menu/main-menu.tscn")

func _on_option_pressed() -> void:
	print("option pressed")

func _on_exit_pressed() -> void:
	get_tree().quit()
