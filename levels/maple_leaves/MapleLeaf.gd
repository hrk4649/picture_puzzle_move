extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    # choose an animation randomly
    var list = $AnimationPlayer.get_animation_list()
    var anim = list[randi() % list.size()]
    $AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(_anim_name):
    pass # Replace with function body.
    queue_free()
