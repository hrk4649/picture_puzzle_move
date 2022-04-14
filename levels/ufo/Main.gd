extends Spatial

func _ready():
    play_ufo_animation()

func play_ufo_animation():
    var list = $AnimationPlayer.get_animation_list()
    #print("list:"+str(list))
    # skip choosing list[0] because it is "RESET" 
    var idx = randi() % (list.size() - 1) + 1
    #print("idx:"+str(idx))
    var anim = list[idx]
    $AnimationPlayer.play(anim)

func _on_AnimationPlayer_animation_finished(anim_name):
    play_ufo_animation()
