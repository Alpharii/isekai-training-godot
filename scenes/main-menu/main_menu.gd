extends Control

# 1. Path menuju Scene Pop-up yang sudah kita buat dan rapikan kemarin
# PASTIKAN path ini sesuai dengan letak file BasePopup.tscn di project kamu!
const POPUP_SCENE = preload("res://components/modal/BasePopup.tscn")

# Tentukan batas maksimal turn game kamu
const MAX_TURN: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Cek turn di awal, siapa tahu game di-load saat posisi turn sudah maksimal
	_check_turn_limit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_exit_game_pressed() -> void:
	get_tree().quit()

func _on_next_turn_pressed() -> void:
	GlobalData.player_data.turn += 1
	print("Turn saat ini: ", GlobalData.player_data.turn)
	
	# Update semua teks UI (Label stat) lewat group
	get_tree().call_group("ui_labels", "update_text")
	
	# 2. Panggil fungsi pengecekan setiap kali turn bertambah
	_check_turn_limit()

# 3. Fungsi baru untuk mengecek kondisi Turn
func _check_turn_limit() -> void:
	var data = GlobalData.player_data
	
	# Jika turn sudah mencapai atau melewati batas maksimal
	if data.turn >= MAX_TURN:
		_show_game_ending_popup(data)

# 4. Fungsi baru untuk merakit dan menampilkan Pop-up Game Over
func _show_game_ending_popup(data: PlayerData) -> void:
	# Buat instance/object dari scene pop-up
	var popup = POPUP_SCENE.instantiate() as BasePopup
	add_child(popup)
	
	# Susun teks rangkuman hasil akhir training karakter
	var ringkasan_stat = "Waktu training telah habis!\n\n"
	ringkasan_stat += "STR: %d | END: %d | DEX: %d\n" % [data.strength, data.endurance, data.dexterity]
	ringkasan_stat += "MAG: %d | WIS: %d | CHA: %d" % [data.magic, data.wisdom, data.charisma]
	
	# Konfigurasi isi pop-up lewat fungsi setup bawaannya
	popup.setup(
		"TRAINING SELESAI", # Judul
		ringkasan_stat,     # Pesan / Deskripsi
		"Main Lagi",        # Teks tombol confirm
		"Keluar"            # Teks tombol cancel
	)
	
	# Hubungkan sinyal tombol pop-up ke fungsi lokal di bawah ini
	popup.confirmed.connect(_on_popup_restart)
	popup.canceled.connect(_on_popup_exit)

# --- FUNGSI AKSI UNTUK TOMBOL DI DALAM POP-UP ---

func _on_popup_restart() -> void:
	# Reset semua data player kembali ke nilai awal sebelum mengulang game
	var data = GlobalData.player_data
	data.turn = 1
	data.strength = 12
	data.endurance = 8
	data.magic = 17
	data.wisdom = 11
	data.dexterity = 9
	data.charisma = 10
	
	# Reload scene ini agar berjalan segar dari awal lagi
	get_tree().reload_current_scene()

func _on_popup_exit() -> void:
	# Jika ditekan keluar, kita tutup game (atau bisa kamu ganti ke scene start-menu)
	get_tree().quit()
