class_name Player
extends CharacterBody2D

@export var move_speed := 220.0
@export var jump_velocity := -350.0
@export var gravity := 900.0

@export var world_bounds_top: CollisionShape2D
@export var world_bounds_right: CollisionShape2D
@export var world_bounds_bottom: CollisionShape2D
@export var world_bounds_left: CollisionShape2D

enum PlayerStates {
	IDLE,
	WALKING,
	FALLING,
	JUMPING,
	DEAD,
}

var current_state: PlayerStates = PlayerStates.IDLE

func _ready():
	set_camera_limits()
	GlobalSignals.player_death.connect(_on_player_death)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	# determine current state
	if current_state == PlayerStates.DEAD:
		move_and_slide()
		return
	elif not is_on_floor():
		current_state = PlayerStates.FALLING if velocity.y > 0 else PlayerStates.JUMPING
	elif velocity.x != 0:
		current_state = PlayerStates.WALKING
	else:
		current_state = PlayerStates.IDLE
	
	move_and_slide()

func _input(event):
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * move_speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	
func set_camera_limits() -> void:
	var camera := %PlayerCamera
	
	if world_bounds_top != null:
		camera.limit_top = world_bounds_top.position.y
	
	if world_bounds_bottom != null:
		camera.limit_bottom = world_bounds_bottom.position.y
		
	if world_bounds_right != null:
		camera.limit_right = world_bounds_right.position.x
		
	if world_bounds_left != null:
		camera.limit_left = world_bounds_left.position.x

func _on_player_death() -> void:
	print("player death caught in player")
	current_state = PlayerStates.DEAD
	velocity.y = jump_velocity
	
