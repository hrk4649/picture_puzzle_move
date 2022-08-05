extends Spatial

var current_target

var ufo

func _ready():
    pass
    ufo = $UFO
    decide_target()

func decide_target():
    pass

    # choose next target
    var targets = []
    for cand in $Targets.get_children():
        var distance = (cand.transform.origin - ufo.transform.origin).length()
        if distance > 5:
            targets.push_back(cand)
    
    current_target = targets[randi() % targets.size()]
    var position = current_target.transform.origin
    ufo.target_position = position

func _on_Target_body_entered(body):
    pass # Replace with function body.
    decide_target()

