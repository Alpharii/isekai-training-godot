extends Label

enum StatType { STRENGTH, ENDURANCE, DEXTERITY, MAGIC, WISDOM, CHARISMA }

@export var tipe_stat: StatType = StatType.STRENGTH

const playerData = preload("res://resources/data/player-data.tres")

func _ready() -> void:
	match tipe_stat:
		StatType.STRENGTH:
			text = str(playerData.strength)
		StatType.ENDURANCE:
			text = str(playerData.endurance)
		StatType.DEXTERITY:
			text = str(playerData.dexterity)
		StatType.MAGIC:
			text = str(playerData.magic)
		StatType.WISDOM:
			text = str(playerData.wisdom)
		StatType.CHARISMA:
			text = str(playerData.charisma)
