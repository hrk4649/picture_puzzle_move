extends KinematicBody

var velocity = Vector3.ZERO
var acceleration = Vector3.ZERO
var target_position = Vector3.ZERO

func _ready():
    pass # Replace with function body.
    $AnimationTree.active = true

func _physics_process(delta):
    pass
    acceleration = (target_position - transform.origin).normalized() * 0.4
    var friction = velocity * - 0.4
    velocity += (acceleration + friction) * delta
    move_and_collide(velocity)
