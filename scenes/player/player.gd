extends CharacterBody2D

@export var move_speed := 220.0
@export var jump_velocity := -350.0
@export var gravity := 900.0

@export var world_bounds_top: CollisionShape2D
@export var world_bounds_right: CollisionShape2D
@export var world_bounds_bottom: CollisionShape2D
@export var world_bounds_left: CollisionShape2D

func _ready():
	set_camera_limits()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * move_speed

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()

#func set_camera_boundaries(top: Vector2, right: Vector2, bottom: Vector2, left: Vector2) -> void:
	#var camera := %Camera2D
	#
	#camera.limit_bottom = bottom.y
	#camera.limit_left = left.x
	#camera.limit_top = top.y
	#camera.limit_right = right.x
	
func set_camera_limits() -> void:
	var camera := %Camera2D
	
	if world_bounds_top != null:
		camera.limit_top = world_bounds_top.position.y
	
	if world_bounds_bottom != null:
		camera.limit_bottom = world_bounds_bottom.position.y
		
	if world_bounds_right != null:
		camera.limit_right = world_bounds_right.position.x
		
	if world_bounds_left != null:
		camera.limit_left = world_bounds_left.position.x
