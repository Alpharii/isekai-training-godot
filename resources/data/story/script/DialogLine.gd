extends Resource
class_name DialogLine

@export var speaker: String = ""
@export_file("*.png") var background: String = ""
@export_file("*.png") var character_image: String = ""
@export_multiline var text: String = "" # @export_multiline membuat kotak ketikan teks jadi luas di Inspector
