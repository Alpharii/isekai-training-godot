extends CanvasLayer
class_name BasePopup

# Ambil referensi node-node UI di dalam pop-up secara presisi
# (Sesuaikan nama jalurnya jika berbeda dengan struktur scene tree kamu)
@onready var title_label: Label = $PanelContainer/MarginContainer/VBoxContainer/TextContainer/CustomLabel
@onready var message_label: Label = $PanelContainer/MarginContainer/VBoxContainer/TextContainer/CustomLabel2
@onready var confirm_button: Button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Button
@onready var cancel_button: Button = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Button2

# Sinyal yang akan dilempar keluar saat tombol diklik
signal confirmed
signal canceled

func _ready() -> void:
	# Hubungkan aksi klik tombol langsung via kode
	confirm_button.pressed.connect(_on_confirm_pressed)
	cancel_button.pressed.connect(_on_cancel_pressed)

# FUNGSI UTAMA: Ini yang dicari oleh main_menu.gd kamu!
func setup(title: String, message: String, confirm_text: String = "OK", cancel_text: String = "") -> void:
	title_label.text = title
	message_label.text = message
	confirm_button.text = confirm_text
	
	# Jika tombol cancel tidak diberi teks khusus, sembunyikan saja tombolnya
	if cancel_text == "":
		cancel_button.hide()
	else:
		cancel_button.show()
		cancel_button.text = cancel_text

func _on_confirm_pressed() -> void:
	emit_signal("confirmed")
	queue_free() # Hapus pop-up dari memori setelah selesai diklik

func _on_cancel_pressed() -> void:
	emit_signal("canceled")
	queue_free() # Hapus pop-up dari memori setelah selesai diklik
