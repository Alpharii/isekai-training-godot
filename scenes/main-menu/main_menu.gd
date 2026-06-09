extends Control

const POPUP_SCENE = preload("res://components/modal/BasePopup.tscn")
const MAX_TURN: int = 5

@onready var energy_bar: ProgressBar = $Energy/EnergyBar

func _ready() -> void:
	_update_ui_elements()
	_check_game_conditions()

func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _on_next_turn_pressed() -> void:
	GlobalData.player_data.turn += 1
	print("Turn saat ini: ", GlobalData.player_data.turn)
	
	get_tree().call_group("ui_labels", "update_text")
	_update_ui_elements()
	_check_game_conditions()
	
# 2. Fungsi terpusat untuk mengupdate seluruh UI termasuk Bar Energi
func _update_ui_elements() -> void:
	var data = GlobalData.player_data
	
	# Update seluruh label stat yang masuk grup "ui_labels"
	get_tree().call_group("ui_labels", "update_text")
	
	# Update nilai bar energi secara langsung dari data player
	if energy_bar:
		energy_bar.value = data.energy
		
	# Opsional: Jika kamu punya Max Energy dinamis, kamu juga bisa set:
	# energy_bar.max_value = data.max_energy

# Fungsi Pengecekan Terpadu (Turn & Stamina)
func _check_game_conditions() -> void:
	var data = GlobalData.player_data
	
	# 1. Cek jika player kelelahan/energy habis duluan sebelum turn selesai
	if data.energy <= 0:
		_show_exhausted_popup(data)
		return # Keluar dari fungsi agar tidak menimpa dengan pop-up turn limit
		
	# 2. Cek jika turn sudah mencapai atau melewati batas maksimal
	if data.turn >= MAX_TURN:
		_show_game_ending_popup(data)

# Pop-up ketika Turn Habis (Normal Ending)
func _show_game_ending_popup(data: PlayerData) -> void:
	var popup = POPUP_SCENE.instantiate() as BasePopup
	add_child(popup)
	
	var ringkasan_stat = "Waktu training telah habis!\n\n"
	ringkasan_stat += "STR: %d | END: %d | DEX: %d\n" % [data.strength, data.endurance, data.dexterity]
	ringkasan_stat += "MAG: %d | WIS: %d | CHA: %d" % [data.magic, data.wisdom, data.charisma]
	
	popup.setup(
		"TRAINING SELESAI", 
		ringkasan_stat,     
		"Main Lagi",        
		"Keluar"            
	)
	
	popup.confirmed.connect(_on_popup_restart)
	popup.canceled.connect(_on_popup_exit)

# Pop-up BARU ketika Stamina Habis (Bad/Exhausted Ending)
func _show_exhausted_popup(data: PlayerData) -> void:
	var popup = POPUP_SCENE.instantiate() as BasePopup
	add_child(popup)
	
	var ringkasan_stat = "Karaktermu pingsan karena terlalu lelah bekerja keras!\n\n"
	ringkasan_stat += "STR: %d | END: %d | DEX: %d\n" % [data.strength, data.endurance, data.dexterity]
	ringkasan_stat += "MAG: %d | WIS: %d | CHA: %d" % [data.magic, data.wisdom, data.charisma]
	
	popup.setup(
		"GAME OVER: KELELAHAN", # Judul berbeda
		ringkasan_stat,
		"Coba Lagi",            # Tombol confirm
		"Keluar"
	)
	
	# Tetap hubungkan ke fungsi reset yang sama agar bisa mengulang game
	popup.confirmed.connect(_on_popup_restart)
	popup.canceled.connect(_on_popup_exit)

# Reset Game
func _on_popup_restart() -> void:
	var data = GlobalData.player_data
	data.turn = 1
	# Jangan lupa reset energy/energi ke nilai awal penuh saat main lagi!
	data.energy = 100 
	
	data.strength = 12
	data.endurance = 8
	data.magic = 17
	data.wisdom = 11
	data.dexterity = 9
	data.charisma = 10
	
	get_tree().reload_current_scene()

func _on_popup_exit() -> void:
	get_tree().quit()
