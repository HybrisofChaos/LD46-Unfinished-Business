extends Node

onready var navigation_map = $PathMap
onready var player = $Player
onready var demon = $Demon


# Performed when added to scene
func _ready():
	# Connects the whistle to creating a new path
	player.connect("WHISTLE", self, "_calculate_new_path")

# Calculates a new path and gives to demon
func _calculate_new_path():
	var path = navigation_map.getMyPath(demon.position, player.position)

	if path:
		
		path.remove(0)
		
		demon.path = path
