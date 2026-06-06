extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _on_next_turn_pressed() -> void:
	GlobalData.player_data.turn += 1
	print("Turn saat ini: ", GlobalData.player_data.turn)
	
	get_tree().call_group("ui_labels", "update_text")
