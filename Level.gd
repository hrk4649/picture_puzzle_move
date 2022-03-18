extends Node2D


var key_hook = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


func _input(event):
    if(!visible):
        return
    key_hook = input_init(event)

func input_init(event):
    pass
    var key_pressed = false

    if event.is_action_pressed("ui_accept"):
        key_pressed = true
    elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
        key_pressed = true
       
    if key_pressed and !key_hook:
        _on_Button_pressed()

    return key_pressed

func grab_focus():
    pass
    $ItemList.grab_focus()
    #$ItemList.select(0)

func choose_level(index):
    var level = "dragon_fly"
    var num_pieces = 9
    get_parent().change_scene_game(level, num_pieces)

func _on_Button_pressed():
    pass # Replace with function body.
    var items = $ItemList.get_selected_items()
    if items != null and items.size() == 1:
        $ItemList.unselect_all()
        var index = items[0]
        choose_level(index)


func _on_ItemList_item_activated(index):
    pass # Replace with function body.
    $ItemList.unselect_all()
    choose_level(index)
