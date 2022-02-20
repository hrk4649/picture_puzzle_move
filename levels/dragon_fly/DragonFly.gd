extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var speed = 300

var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    #var radian = velocity.angle()
    #rotation = PI * 0.5 + velocity.angle()

func set_velocity_by_rotation():
    pass
    var fix = rotation - PI * 0.5
    velocity = Vector2(cos(fix), sin(fix)) * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func _physics_process(delta):
    pass
    var vel_delta = velocity * delta
    global_transform.origin += vel_delta


func _on_VisibilityNotifier2D_screen_exited():
    pass # Replace with function body.
    print("_on_VisibilityNotifier2D_screen_exited")
    queue_free()
