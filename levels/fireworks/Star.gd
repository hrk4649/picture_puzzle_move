extends Spatial

export var duration:float = 0
export var max_deviation:float = 1.0

var burn_time = 0

var deviation = 0

# velocity is initialized by Ball.gd
var velocity = Vector3.UP

var gravity = Vector3.DOWN * 9.8 * 0.5

func _ready():
    pass # Replace with function body.
    deviation = rand_range(0.0, max_deviation)

func _process(delta):
    if visible:
        transform.origin += velocity * delta
        var friction = velocity * - 0.9
        velocity += (gravity + friction) * delta

        burn_time += delta

        if burn_time > duration + deviation:
            visible = false
            burn_time = 0
            deviation = rand_range(0.0, max_deviation)
