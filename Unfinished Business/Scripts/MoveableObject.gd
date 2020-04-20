extends KinematicBody2D

export (float) var movementCooldown = 1.5
export (NodePath) var myBody
export (NodePath) var myGlow

var current_health = 1000

var originalPos: Vector2

const GRAVITY = 100
var velocity = Vector2()

var selected = false

func _ready():
	myBody = get_node(myBody)
	myGlow = get_node(myGlow)

func _process(_delta):
	update() 
	checkForInput()
	myGlow.visible = selected

func _physics_process(delta):
	if !selected:
		velocity.y += delta * GRAVITY
	else:
		velocity = Vector2.ZERO	
		
	var motion = velocity * delta
	move_and_collide(motion)	

func checkForInput():
	if Input.is_action_just_pressed("telekenesis"):
		if !selected:
			if checkIfMeantForMe():
				selected = true
		else:
			selected = false
	if selected:
		global_position = get_global_mouse_position()	

func checkIfMeantForMe():
	var objects = get_world_2d().direct_space_state.intersect_point(get_global_mouse_position())
	for i in range(0, objects.size()):
		if objects[i].collider == myBody:
			return true
	return false	

func _input(event):
	if event is InputEventMouseMotion && selected:
		global_position += event.relative	
		
func apply_damage(damage):
	current_health -= damage
	if current_health <= 0:
		die()

func die():
	#Destoy item?
	pass		
