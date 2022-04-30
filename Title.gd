extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    $AnimationPlayer.play("forth_and_back")

func _input(event):
    if(!visible):
        return
    accept_event()
    input_init(event)

func input_init(event):
    pass
    var key_pressed = false

    if event.is_action_pressed("ui_accept"):
        key_pressed = true
    elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
        key_pressed = true
       
    if key_pressed:
        get_parent().change_scene_level()
    return key_pressed

func grab_focus():
    pass
