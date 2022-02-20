extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_ItemList_item_selected(index):
    pass # Replace with function body.
    $ItemList.unselect_all()
    var level = "dragon_fly"
    var num_pieces = 9
    get_parent().change_scene_game(level, num_pieces)
