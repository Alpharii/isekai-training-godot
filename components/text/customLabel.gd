extends Label

func _ready() -> void:
	add_to_group("ui_labels")
	update_text()

enum TextType { STRENGTH, ENDURANCE, DEXTERITY, MAGIC, WISDOM, CHARISMA, TURN }

@export var tipe_text: TextType = TextType.STRENGTH

const playerData = preload("res://resources/data/player-data.tres")

func update_text() -> void:
	var data = GlobalData.player_data
	match tipe_text:
		TextType.STRENGTH:
			text = str(data.strength)
		TextType.ENDURANCE:
			text = str(data.endurance)
		TextType.DEXTERITY:
			text = str(data.dexterity)
		TextType.MAGIC:
			text = str(data.magic)
		TextType.WISDOM:
			text = str(data.wisdom)
		TextType.CHARISMA:
			text = str(data.charisma)
		TextType.CHARISMA:
			text = str(data.charisma)
		TextType.TURN:
			text = "Turn: " + str(data.turn)
