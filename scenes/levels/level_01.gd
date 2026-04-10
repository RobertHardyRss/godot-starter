extends Node2D

@onready var player := $PlayerSpawn/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#player.set_camera_boundaries(
		#$WorldBoundary/Top.position,
		#$WorldBoundary/Right.position,
		#$WorldBoundary/Bottom.position,
		#$WorldBoundary/Left.position
	#)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
