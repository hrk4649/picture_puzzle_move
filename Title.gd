extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
    $AnimationPlayer.play("forth_and_back")

func grab_focus():
    pass
    $Start.grab_focus()

func _on_Credit_pressed():
    pass # Replace with function body.
    get_parent().change_scene_credit()


func _on_Start_pressed():
    pass # Replace with function body.
    get_parent().change_scene_level()
