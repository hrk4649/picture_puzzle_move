extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    play_ufo_animation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
func play_ufo_animation():
    var list = $AnimationPlayer.get_animation_list()
    print("list:"+str(list))
    # skip choosing list[0] because it is "RESET" 
    var idx = randi() % (list.size() - 1) + 1
    print("idx:"+str(idx))
    var anim = list[idx]
    $AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(anim_name):
    pass # Replace with function body.
    play_ufo_animation()
