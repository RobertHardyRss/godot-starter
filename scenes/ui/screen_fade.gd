class_name ScreenFade
extends ColorRect

signal faded_out
signal faded_in

func _ready():
	visible = false

func fade_out() -> void:
	modulate.a = 0.0
	show()
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	tween.tween_callback(faded_out.emit)
	
func fade_in() -> void:
	modulate.a = 1.0
	show()
	
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	tween.tween_callback(self.hide)
	tween.tween_callback(faded_in.emit)
