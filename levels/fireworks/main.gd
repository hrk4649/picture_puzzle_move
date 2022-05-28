extends Spatial

func _on_Timer_timeout():
    pass # Replace with function body.
    #print("_on_Timer_timeout")
    if $Ball1.visible != true:
        init_ball($Ball1)
        set_wait_time()
    elif $Ball2.visible != true:
        init_ball($Ball2)
        set_wait_time()
    elif $Ball3.visible != true:
        init_ball($Ball3)
        set_wait_time()

func set_wait_time():
    $Timer.wait_time = rand_range(0.5, 4)

func init_ball(ball):
    pass
    var pos1 = $Positions/Position3D1.transform.origin
    var pos2 = $Positions/Position3D2.transform.origin
    var ball_position = Vector3(
            rand_range(pos1.x, pos2.x),
            rand_range(pos1.y, pos2.y),
            rand_range(pos1.z, pos2.z)
       )
    ball.transform.origin = ball_position
    ball.init_stars()
    ball.visible = true
