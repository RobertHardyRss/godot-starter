extends Node2D

var score := 0
var coins_total := 0

@onready var hud = $UILayer/HUD

func _ready() -> void:
	reset_level()

func _on_coin_collected() -> void:
	score += 1
	hud.set_score(score)

	if score >= coins_total:
		hud.show_message("You win!")
		%ScreenFade.fade_out()


func load_next_level() -> void:
	# we need to get the current level
	var current_level = %LevelHolder.get_child(0)
	if current_level == null:
		# how do we even get here?
		# maybe end game?
		return
	
	var next_level_path : String = current_level.get("next_level")
	
	if next_level_path != null:
		var next_level = load(next_level_path)
		var level = next_level.instantiate()
		
		if level is BaseLevel:
			current_level.queue_free()
			%LevelHolder.add_child(level)
			reset_level()
			%ScreenFade.fade_in()
	
	# if we get here without a level we are hosed
	# maybe create a game over scene for a fallback


func reset_level() -> void:
	score = 0
	var coins = get_tree().get_nodes_in_group("coins")
	coins_total = coins.size()

	for coin in coins:
		coin.collected.connect(_on_coin_collected)

	hud.set_score(score)
	hud.show_message("Collect all the coins!")


func _on_screen_fade_faded_out():
	load_next_level()
