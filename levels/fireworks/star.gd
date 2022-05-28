extends Spatial


var velocity = Vector3.UP * 50

var gravity = Vector3(0, -9.8, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if visible:
        var slow = 1.0
        transform.origin += velocity * delta * slow
        velocity += gravity * delta * slow

        # remove the node if origin of this node is out of positions
        var pos1 = $Positions/Position3D1.transform.origin
        var pos2 = $Positions/Position3D2.transform.origin
        var this = transform.origin
        
        var out_of_positions = (
            this.x < pos1.x || this.x > pos2.x
            || this.y < pos1.y || this.y > pos2.y
            || this.z < pos1.z || this.z > pos2.z
        )
        
        if out_of_positions:
            #print("star: visible = false")
            visible = false
