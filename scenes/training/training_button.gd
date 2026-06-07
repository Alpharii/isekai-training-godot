extends Button
class_name TrainingButton

# 1. Tentukan daftar nama latihan (bisa kamu tambah sesuka hati)
enum TrainingActivity { PUSH_UP, SHOOTING, READING, MEDITATION, DANCING }

@export_category("Training Configuration")
@export var aktivitas: TrainingActivity = TrainingActivity.PUSH_UP

# Nilai RNG (Rentang Min dan Max bonus stat)
@export var min_bonus: int = 5
@export var max_bonus: int = 10

# Pilihan warna tombol lewat Inspector
@export var button_color: Color = Color.WHITE

func _ready() -> void:
	pressed.connect(_on_training_pressed)
	
	# Jalankan setup visual saat game dimulai
	_setup_button_visual()

# Fungsi untuk otomatisasi Teks dan Warna Tombol
func _setup_button_visual() -> void:
	# Mengatur teks berdasarkan aktivitas yang dipilih
	match aktivitas:
		TrainingActivity.PUSH_UP:
			text = "Push Up\n(+STR, +END)"
		TrainingActivity.SHOOTING:
			text = "Latihan Menembak\n(+DEX, +STR)"
		TrainingActivity.READING:
			text = "Membaca Buku\n(+WIS, +MAG)"
		TrainingActivity.MEDITATION:
			text = "Meditasi\n(+CHA, +WIS)"
		TrainingActivity.DANCING:
			text = "Kelas Dansa\n(+CHA, +DEX)"
			
	# Mengatur warna modulasi tombol (Self Modulate agar style asli/font tidak rusak)
	self.self_modulate = button_color

func _on_training_pressed() -> void:
	var data = GlobalData.player_data
	
	# Mengambil angka acak antara min_bonus sampai max_bonus (inklusif)
	var rng_bonus_1 = randi_range(min_bonus, max_bonus)
	var rng_bonus_2 = randi_range(min_bonus, max_bonus)
	
	# 2. Eksekusi logika multi-stat & RNG berdasarkan aktivitas
	match aktivitas:
		TrainingActivity.PUSH_UP:
			data.strength += rng_bonus_1
			data.endurance += rng_bonus_2
			print("Push Up selesai! STR +", rng_bonus_1, " | END +", rng_bonus_2)
			
		TrainingActivity.SHOOTING:
			data.dexterity += rng_bonus_1
			data.strength += rng_bonus_2
			print("Menembak selesai! DEX +", rng_bonus_1, " | STR +", rng_bonus_2)
			
		TrainingActivity.READING:
			data.wisdom += rng_bonus_1
			data.magic += rng_bonus_2
			
		TrainingActivity.MEDITATION:
			data.charisma += rng_bonus_1
			data.wisdom += rng_bonus_2
			
		TrainingActivity.DANCING:
			data.charisma += rng_bonus_1
			data.dexterity += rng_bonus_2

	# 3. Majukan turn dan update UI
	data.turn += 1
	if owner and owner.has_method("_check_turn_limit"):
			owner._check_turn_limit()
	get_tree().call_group("ui_labels", "update_text")
