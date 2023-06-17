extends Spatial

var Smoke = preload("res://levels/sl/smoke.tscn")

onready var sl = get_node("%SL")
onready var path1 = get_node("%Path1")
onready var path_follow1 = get_node("%PathFollow1")
onready var path2 = get_node("%Path2")
onready var path_follow2 = get_node("%PathFollow2")

var last_rotation

var path
var path_follow

func _ready():
    pass # Replace with function body.
    choice_path()

func choice_path():
    var choice = randi() % 2 + 1
    #var choice = 1
    match choice:
        1:
            path = path1
            path_follow = path_follow1
            change_path1_rotation()
            $AnimationPlayer.play("sl_move_straight")
        2:
            path = path2
            path_follow = path_follow2
            change_path2_rotation()
            $AnimationPlayer.play("sl_move_curve")
        _:
            print("choice_path():invalid choice %s" % choice)

func _process(delta):
    # sl follows PathFollow
    if path_follow != null:
        sl.transform = path_follow.transform
        sl.global_transform = path_follow.global_transform

func put_smoke():
    var smoke = Smoke.instance()
    smoke.global_translation = sl.get_chimney_global_position()
    add_child(smoke)

func change_path1_rotation():
    var rotations = range(45, 360, 90)
    var rotation_lottery_box = []
    for r in rotations:
        if r != last_rotation:
            rotation_lottery_box.push_back(r)
    var choiced = rotation_lottery_box[randi() % rotation_lottery_box.size()]
    path1.rotation_degrees = Vector3(0,choiced,0)
    last_rotation = choiced

func change_path2_rotation():
    var rotations = range(0, 360, 90)
    var rotation_lottery_box = []
    for r in rotations:
        if r != last_rotation:
            rotation_lottery_box.push_back(r)
    var choiced = rotation_lottery_box[randi() % rotation_lottery_box.size()]
    path2.rotation_degrees = Vector3(0,choiced,0)
    last_rotation = choiced

func _on_AnimationPlayer_animation_finished(anim_name):
    choice_path()

func _on_Timer_timeout():
    put_smoke()
