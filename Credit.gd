extends Control

var CreditItem = preload("res://parts/CreditItem.tscn")

func _ready():
    pass # Replace with function body.
    var file = File.new()
    file.open("res://LICENSE.tres", File.READ)
    var text = file.get_as_text()
    file.close()
    var item = CreditItem.instance()
    $ScrollContainer/VBoxContainer.add_child(item)
    item.text = text

func _input(event):
    if !visible:
        return
    if event.is_action_pressed("ui_up"):
        $ScrollContainer.scroll_vertical += -80
        accept_event()
    elif event.is_action_pressed("ui_down"):
        $ScrollContainer.scroll_vertical += 80
        accept_event()
    
func grab_focus():
    $Button.grab_focus()
    $ScrollContainer.scroll_vertical = 0
    
func _on_Button_pressed():
    pass # Replace with function body.
    get_parent().change_scene_title()

