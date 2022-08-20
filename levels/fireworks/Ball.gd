extends Spatial


var Star = load(get_script().resource_path.get_base_dir() + "/Star.tscn")

export var init_star_speed = 10

var stars = null

func _ready():
    pass # Replace with function body.
    init_stars()

func init_stars():
    var radius0 = 60
    var num_star0 = 12
    #var init_velocity = 10
    var idx = 0
    for deg1 in range(75, -76, -15):
        var radius1 = radius0 * cos(deg2rad(deg1))
        var num_star1 = int(num_star0 * radius1 / radius0)
        for deg2 in range(0, 361, 360.0 / num_star1):
            var star = null
            if idx < get_child_count():
                star = get_child(idx)
            else:
                star = Star.instance()
                add_child(star)
            star.velocity = Vector3.RIGHT.rotated(
                Vector3.BACK, 
                deg2rad(deg1)).rotated(
                    Vector3.UP, 
                    deg2rad(deg2)) * init_star_speed
            star.transform.origin = Vector3.ZERO
            star.visible = true
            idx += 1

func _process(delta):
    if visible:
        var all_invisible = true
        for idx in range(0, get_child_count()):
            var star = get_child(idx)
            if star.visible:
                all_invisible = false
                break
        if all_invisible:
            #print("ball: visible = false")
            visible = false

