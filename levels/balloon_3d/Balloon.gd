extends RigidBody


#var velocity = Vector3.ZERO
var acceralation = Vector3.UP * 10


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    init_acceralation()

func _integrate_forces(state):
    pass
    var vel_horizon = Vector3(state.linear_velocity.x, 0, state.linear_velocity.z)
    var drag_horizon = - 0.01 * vel_horizon.length_squared()
    
    var vel_vertical = Vector3(0, state.linear_velocity.y, 0)
    var drag_vertical = - 0.01 * vel_vertical.length_squared()
    #acceralation += (vel_horizon * drag_horizon)
    state.add_central_force(
        acceralation * state.step
         + vel_horizon * drag_horizon * state.step
         + vel_vertical * drag_vertical * state.step
        )
    if global_transform.origin.y >= 100:
        queue_free()
    

func init_acceralation():
    pass
    acceralation = Vector3.UP * 10 + Vector3(rand_range(-5,5), 0, rand_range(-5,5))
