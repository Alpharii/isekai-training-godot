extends Resource
class_name EventStoryData

@export var event_id: String = "main_001"
@export var trigger_turn: int = 0
@export var stat_requirment: String = "none"
@export var stat_requirment_value: int = 0;

@export var dialog_lines: Array[DialogLine] = []

func is_condition_met(player_data: PlayerData) -> bool:
	# 1. Cek apakah turn saat ini cocok dengan trigger_turn di Resource
	if player_data.turn != trigger_turn:
		return false
		
	# 2. Cek apakah ada syarat stat khusus yang harus dipenuhi
	if stat_requirment != "none" and stat_requirment in player_data:
		if player_data[stat_requirment] < stat_requirment_value:
			return false
			
	# 3. PINTU RAHASIA: Tempat logika ribet/custom berdasarkan event_id
	match event_id:
		"event_rahasia_mentor":
			if player_data.strength > 80 and player_data.wisdom == 0:
				return true
			else:
				return false
				
		"event_kebetulan_hoki":
			return randf() <= 0.10
			
	# Jika turn dan stat_requirment terpenuhi (dan bukan id event custom), maka jalan!
	return true
