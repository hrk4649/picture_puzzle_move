extends TextureRect


var color_rect
var anim_player

func _ready():
    color_rect = $ColorRect
    color_rect.rect_size = self.rect_size
    anim_player = $AnimationPlayer

func move_animation(next_position):
    pass
    #var anim = $AnimationPlayer.get_animation("move")
    var anim = Animation.new()
    var track_index_x = anim.add_track(Animation.TYPE_VALUE)
    anim.track_set_path(track_index_x, ":rect_position:x")
    var track_index_y = anim.add_track(Animation.TYPE_VALUE)
    anim.track_set_path(track_index_y, ":rect_position:y")
    var positions = [rect_position, next_position]
    for idx in range(0, positions.size()):
        pass
        var time = idx * 0.2
        anim.track_insert_key(track_index_x, time, positions[idx].x)
        anim.track_insert_key(track_index_y, time, positions[idx].y)
        anim.length = time
    anim_player.remove_animation("move")
    anim_player.add_animation("move", anim)
    anim_player.play("move")

func select_animation():
    pass
    anim_player.play("select")

func _on_AnimationPlayer_animation_finished(anim_name):
    pass # Replace with function body.
    print("_on_AnimationPlayer_animation_finished")
