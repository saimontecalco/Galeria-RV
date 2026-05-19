extends RigidBody3D
var speed = 0.1
@onready var spring_arm_3d: SpringArm3D = $SpringArm3D
var mouse=0.01

func _input(event:InputEvent):
	if event is InputEventMouseMotion:
		spring_arm_3d.rotation.x -= event.relative.y * mouse
		spring_arm_3d.rotation.y -= event.relative.x * mouse
		#spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, -PI/2, PI/4)
		spring_arm_3d.rotation.x = clamp(spring_arm_3d.rotation.x, deg_to_rad(-60), PI/4)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spring_arm_3d.top_level = true
	spring_arm_3d.spring_length=5.0
	spring_arm_3d.rotation_degrees.x=-20.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spring_arm_3d.global_position = self.global_position
	pass
func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var inputDirection = Vector3(
		Input.get_axis("Izquierda","Derecha"),
		0,
		Input.get_axis("Up","Down")
	)
	inputDirection = inputDirection.rotated(Vector3.UP, spring_arm_3d.rotation.y).normalized() * speed
	
	apply_central_impulse(Vector3(inputDirection.x, 0, inputDirection.z))
