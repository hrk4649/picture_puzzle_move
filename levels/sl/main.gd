extends Spatial

var Smoke = preload("res://levels/sl/smoke.tscn")

onready var sl = get_node("%SL")

func _ready():
    pass # Replace with function body.
    $AnimationPlayer.play("sl_move_straight")

func put_smoke():
    var smoke = Smoke.instance()
    smoke.global_translation = sl.get_chimney_global_position()
    add_child(smoke)


func _on_AnimationPlayer_animation_finished(anim_name):
    $AnimationPlayer.play("sl_move_straight")
