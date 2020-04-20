extends MarginContainer

export (NodePath) var player
export (NodePath) var healthBar

func _ready():
	player = get_node(player)
	healthBar = get_node(healthBar)
	healthBar.max_value = player.max_health
	
	
func _process(_delta):
	healthBar.value = player.current_health
