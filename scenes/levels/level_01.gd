extends BaseLevel

@onready var player := $PlayerSpawn/Player

# Called when the node enters the scene tree for the first time.
func _ready():
	next_level = "uid://h7st67rvs6ph" # level 02

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
