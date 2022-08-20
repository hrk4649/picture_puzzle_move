extends RigidBody2D

var velocity = Vector2(0, 0)

var tween_phase = 0

func _ready():
    pass

func _physics_process(delta):
    pass
 
func set_velocity_by_rotation():
    pass
    var fix = rotation - deg2rad(90)
    velocity = Vector2(cos(fix), sin(fix))
    tween_move()

func tween_move():
    pass
    var tween = $Tween
    var destination = position + velocity * rand_range(60, 360)
    tween.interpolate_property(self, "position", self.position, destination, 0.5,
        Tween.TRANS_QUAD ,Tween.EASE_IN_OUT)
    tween.start()

func tween_hover():
    pass
    var tween = $Tween
    var destination = position + velocity * rand_range(10, 60)
    var duration = rand_range(0, 1.0)
    tween.interpolate_property(self, "position", self.position, destination, duration,
        Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
    tween.start()


func _on_VisibilityNotifier2D_screen_exited():
    pass
    queue_free()

func _on_Tween_tween_all_completed():
    pass
    tween_phase = (tween_phase + 1) %2
    match(tween_phase):
        0:
            tween_move()
        1:
            tween_hover()
        _:    
            print("unexpected:value = " + str(tween_phase))
       
