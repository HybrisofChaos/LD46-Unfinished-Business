extends RigidBody2D

export (float) var movementCooldown = 1.5
export (NodePath) var myBody
export (NodePath) var myGlow

var originalPos: Vector2

var selected = false

func _ready():
	myBody = get_node(myBody)
	myGlow = get_node(myGlow)

func _process(_delta):
	update() 
	checkForInput()

func _physics_process(_delta):
	myGlow.visible = selected
	if selected:
		gravity_scale = 0
	else:
		gravity_scale = 1	

func checkForInput():
	if Input.is_action_just_pressed("telekenesis"):
		if !selected:
			if checkIfMeantForMe():
				originalPos = get_global_mouse_position()
				selected = true
		else:
			selected = false

func checkIfMeantForMe():
	var objects = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position())
	for i in range(0, objects.size()):
		if objects[i].collider == myBody:
			return true
	return false	

func _input(event):
	if event is InputEventMouseMotion && selected:
		global_position += event.relative
