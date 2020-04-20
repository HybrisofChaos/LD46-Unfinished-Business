extends MarginContainer

export (NodePath) var player
export (NodePath) var healthBar
export (NodePath) var ammoLabel
export (NodePath) var portal

func _ready():
	player = get_node(player)
	healthBar = get_node(healthBar)
	healthBar.max_value = player.max_health
	
	ammoLabel = get_node(ammoLabel)
	portal = get_node(portal)
	ammoLabel.text = str(portal.base_ammo)
	
	
func _process(_delta):
	healthBar.value = player.current_health
	ammoLabel.text = str(portal.current_ammo)
