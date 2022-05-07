extends TextureRect


var color_rect
# AnimationPlayer for "select"
var anim_player1
# AnimationPlayer for "move"
var anim_player2

var ready_move = false

func _ready():
    color_rect = $ColorRect
    color_rect.rect_size = self.rect_size
    anim_player1 = $AnimationPlayer1
    anim_player2 = $AnimationPlayer2

func is_moving():
    pass
    return anim_player1.is_playing()

func move_animation(next_position):
    pass
    var anim = Animation.new()
    var track_index_x = anim.add_track(Animation.TYPE_VALUE)
    anim.track_set_path(track_index_x, ":rect_position:x")
    var track_index_y = anim.add_track(Animation.TYPE_VALUE)
    anim.track_set_path(track_index_y, ":rect_position:y")
    var positions = [rect_position, next_position]
    var time_unit = 0.2
    for idx in range(0, positions.size()):
        pass
        var time = idx * time_unit
        anim.track_insert_key(track_index_x, time, positions[idx].x)
        anim.track_insert_key(track_index_y, time, positions[idx].y)
    anim.step = 0.1
    anim.length = time_unit * positions.size()
    anim_player2.remove_animation("move")
    anim_player2.add_animation("move", anim)
    anim_player2.play("move")


func select_animation():
    pass
    anim_player1.play("select")

func _on_AnimationPlayer_animation_finished(anim_name):
    pass # Replace with function body.
    print("_on_AnimationPlayer_animation_finished:" + anim_name)
