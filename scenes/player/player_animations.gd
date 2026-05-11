extends Node2D

@export var anim_tree: AnimationTree
@onready var player: Player = get_owner()

var facing = 0

func _physics_process(_delta) -> void:
	var state = player.current_state
	
	if player.velocity.x != 0:
		facing = player.velocity.x
	
	# setup conditions based on current state
	anim_tree.set("parameters/conditions/Falling", state == Player.PlayerStates.FALLING)
	anim_tree.set("parameters/conditions/Idle", state == Player.PlayerStates.IDLE)
	anim_tree.set("parameters/conditions/Jumping", state == Player.PlayerStates.JUMPING)
	anim_tree.set("parameters/conditions/Walking", state == Player.PlayerStates.WALKING)
	anim_tree.set("parameters/conditions/Dead", state == Player.PlayerStates.DEAD)

	# set blend to player velocity x
	anim_tree.set("parameters/Falling/blend_position", facing)
	anim_tree.set("parameters/Idle/blend_position", facing)
	anim_tree.set("parameters/Jumping/blend_position", facing)
	anim_tree.set("parameters/Walking/blend_position", facing)
