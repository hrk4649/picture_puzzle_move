extends RigidBody

var acceralation = Vector3.UP * 10

func _ready():
    pass # Replace with function body.
    init_acceralation()
    
    # Animation
    $AnimationPlayer1.play("sway")
    var length = $AnimationPlayer1.current_animation_length
    var position = rand_range(0, length)
    $AnimationPlayer1.seek(position)
    $AnimationPlayer1.playback_speed = rand_range(0.5, 1)

func _integrate_forces(state):
    pass
    var vel_horizon = Vector3(state.linear_velocity.x, 0, state.linear_velocity.z)
    var friction_horizon = - 0.1 * vel_horizon
#
    acceralation += (friction_horizon * state.step)
    state.add_central_force(acceralation * state.step)
    if global_transform.origin.y >= 150:
        queue_free()

func init_acceralation():
    pass
    acceralation = Vector3.UP * 5 + Vector3(rand_range(-4,4), 0, rand_range(-4,4))
