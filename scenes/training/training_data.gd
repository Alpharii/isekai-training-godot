extends Resource
class_name TrainingData

@export_category("Visual")
@export var nama_latihan: String = "Push Up"
@export var desc_latihan: String = "++STR +END"
@export var warna_tombol: Color = Color.WHITE

@export_category("Cost")
@export var energy_cost: int = 10

@export_category("Stat 1 Setup")
@export_enum("strength", "endurance", "dexterity", "wisdom", "magic", "charisma") var stat_1: String = "strength"
@export var min_stat_1: int = 5
@export var max_stat_1: int = 10 # Jika diisi 0, stat ini dianggap tidak aktif

@export_category("Stat 2 Setup")
@export_enum("strength", "endurance", "dexterity", "wisdom", "magic", "charisma") var stat_2: String = "endurance"
@export var min_stat_2: int = 5
@export var max_stat_2: int = 10 # Jika diisi 0, stat ini dianggap tidak aktif

@export_category("Stat 3 Setup")
@export_enum("strength", "endurance", "dexterity", "wisdom", "magic", "charisma") var stat_3: String = "magic"
@export var min_stat_3: int = 5
@export var max_stat_3: int = 0 # Di-set 0 secara default agar opsional
