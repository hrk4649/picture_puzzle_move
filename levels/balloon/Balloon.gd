extends AnimatedSprite


var speed = 300

var velocity = Vector2(0, 0)

var start_position = Vector2(0,0)
var center = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func set_velocity_by_rotation():
    pass
    var fix = rotation - PI * 0.5
    velocity = Vector2(cos(fix), sin(fix)) * speed

func init_position(v):
    start_position = global_transform.origin
    center = v

func _physics_process(delta):
    pass
    var vel_delta = velocity * delta
    global_transform.origin += vel_delta

    var distance1 = (global_transform.origin - center).length()
    var distance2 = (start_position - center).length()
    self.scale = Vector2(distance1 / distance2,distance1 / distance2)
    if self.scale.length() < 0.05 :
        queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_VisibilityNotifier2D_screen_exited():
    pass # Replace with function body.
    queue_free()
