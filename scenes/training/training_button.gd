extends Button
class_name TrainingButton

@export var training_resource: TrainingData

func _ready() -> void:
	pressed.connect(_on_training_pressed)
	_setup_button_visual()

func _setup_button_visual() -> void:
	if not training_resource:
		return
		
	var res = training_resource
	var active_stats: Array[String] = []
	
	if res.max_stat_1 > 0:
		active_stats.append(res.stat_1.to_upper().left(3))
	if res.max_stat_2 > 0:
		active_stats.append(res.stat_2.to_upper().left(3))
	if res.max_stat_3 > 0:
		active_stats.append(res.stat_3.to_upper().left(3))
		
	var stat_text = ", ".join(active_stats)
	
	# 1. Pastikan teks bawaan Button utama dikosongkan agar tidak tumpang tindih
	text = ""
	
	# 2. Masukkan Judul ke TitleLabel
	if has_node("VBoxContainer/TitleContainer/TitleLabel"):
		$VBoxContainer/TitleContainer/TitleLabel.text = res.nama_latihan
		
	# 3. Masukkan Deskripsi ke DescLabel dengan format baru tanpa tanda plus
	if has_node("VBoxContainer/DescContainer/DescLabel"):
		$VBoxContainer/DescContainer/DescLabel.text = res.desc_latihan
	
	if has_node("VBoxContainer/DescContainer/EneLabel"):
		$VBoxContainer/DescContainer/EneLabel.text = "-" + str(res.energy_cost) + "Energy"
	
	# Mengatur warna visual tombol
	self.self_modulate = res.warna_tombol

func _on_training_pressed() -> void:
	if not training_resource:
		return
		
	var data = GlobalData.player_data
	var res = training_resource
	
	# Kurangi energy sesuai cost dari resource
	data.energy -= res.energy_cost
	
	var debug_log = res.nama_latihan + " selesai! "
	
	if res.max_stat_1 > 0 and res.stat_1 in data:
		var bonus = randi_range(res.min_stat_1, res.max_stat_1)
		data[res.stat_1] += bonus
		debug_log += "%s +%d | " % [res.stat_1, bonus]
		
	if res.max_stat_2 > 0 and res.stat_2 in data:
		var bonus = randi_range(res.min_stat_2, res.max_stat_2)
		data[res.stat_2] += bonus
		debug_log += "%s +%d | " % [res.stat_2, bonus]
		
	if res.max_stat_3 > 0 and res.stat_3 in data:
		var bonus = randi_range(res.min_stat_3, res.max_stat_3)
		data[res.stat_3] += bonus
		debug_log += "%s +%d | " % [res.stat_3, bonus]
		
	print(debug_log, "Sisa Stamina: ", data.energy)

	# Update turn dan UI
	data.turn += 1
	
	# 2. PANGGIL UPDATE UI DAN CEK KONDISI DI MAIN MENU VIA OWNER
	if owner:
		if owner.has_method("_update_ui_elements"):
			owner._update_ui_elements() # Ini yang akan membuat EnergyBar langsung berkurang di layar
		if owner and owner.has_method("_check_game_conditions"):
			owner._check_game_conditions() # Ini untuk memicu pop-up Game Over jika energy habis
		
	# Tetap panggil grup untuk label stat individual yang menggunakan grup
	get_tree().call_group("ui_labels", "update_text")
		
	get_tree().call_group("ui_labels", "update_text")
