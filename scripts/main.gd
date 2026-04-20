extends Node2D

var score := 0
var coins_total := 0

@onready var hud = $UILayer/HUD

func _ready() -> void:
	reset_scene()

func _on_coin_collected() -> void:
	score += 1
	hud.set_score(score)

	if score >= coins_total:
		hud.show_message("You win!")
		
		# we need to get the current level
		# get the next level resource and load/validate
		# we need to queue_free current level
		# we need a new level instance in LevelHolder


func reset_scene() -> void:
	var coins = get_tree().get_nodes_in_group("coins")
	coins_total = coins.size()

	for coin in coins:
		coin.collected.connect(_on_coin_collected)

	hud.set_score(score)
	hud.show_message("Collect all the coins!")
