extends CharacterBody2D

@onready var anim_tree = %AnimationTree

const SPEED = 300.0

enum facing_direction {
	LEFT = -1,
	RIGHT = 1
}

@export var current_facing = facing_direction.LEFT
@export var bob_amplitude: float = 0.5  # Vertical distance
@export var bob_frequency: float = 2.0  # Speed of bobbing
var start_y: float

func _ready():
	# Store the base Y position
	start_y = position.y

func _input(event):
	pass

func _physics_process(delta):

	var direction = current_facing
	velocity.x = direction * SPEED
	
	anim_tree.set("parameters/Fly/blend_position", velocity.x)
	bobbing_motion()
	move_and_slide()

func bobbing_motion() -> void:
	var time = Time.get_ticks_msec() / 1000.0
	var offset = sin(time * bob_frequency) * bob_amplitude
	position.y = start_y + offset
	
func _on_change_direction_timeout():
	current_facing = facing_direction.RIGHT if current_facing == facing_direction.LEFT else facing_direction.LEFT
	%ChangeDirection.start()


func _on_hurt_box_body_entered(body):
	if body.is_in_group("player"):
		GlobalSignals.player_death.emit()
