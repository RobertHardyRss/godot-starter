extends Node2D

var score := 0
var coins_total := 0

@onready var hud = $UILayer/HUD

enum GameStates {
	NORMAL,
	PLAYER_DEAD,
	LEVEL_COMPLETE
}

var current_state : GameStates = GameStates.NORMAL

func _ready() -> void:
	GlobalSignals.player_death.connect(_on_player_death)
	reset_level()

func _on_coin_collected() -> void:
	score += 1
	hud.set_score(score)

	if score >= coins_total:
		current_state = GameStates.LEVEL_COMPLETE
		hud.show_message("You win!")
		%ScreenFade.fade_out()


func load_next_level() -> void:
	current_state = GameStates.NORMAL
	
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

func reload_current_level() -> void:
	current_state = GameStates.NORMAL
	var current_level = %LevelHolder.get_child(0)
	
	if current_level is BaseLevel:
		var current_level_path = current_level.get("this_level")
		var reload_level = load(current_level_path)
		var level = reload_level.instantiate()
		current_level.queue_free()
		%LevelHolder.add_child(level)
		reset_level()
		%ScreenFade.fade_in()
	
	
	
	
func reset_level() -> void:
	score = 0
	var coins = get_tree().get_nodes_in_group("coins")
	coins_total = coins.size()

	for coin in coins:
		coin.collected.connect(_on_coin_collected)

	hud.set_score(score)
	hud.show_message("Collect all the coins!")


func _on_screen_fade_faded_out():
	match current_state:
		GameStates.LEVEL_COMPLETE:
			load_next_level()
		GameStates.PLAYER_DEAD:
			reload_current_level()

func _on_player_death():
	current_state = GameStates.PLAYER_DEAD
	%ScreenFade.fade_out()
