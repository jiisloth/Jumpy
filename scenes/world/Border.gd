extends Node2D

func _input(event):
    if not event is InputEventScreenTouch:
        return
    if event.pressed:
        Input.action_press("Activate")
    else:
        Input.action_release("Activate")
        
        
func _process(delta):
    var player = get_tree().get_nodes_in_group("Player")
    if len(player) > 0:
        player = player[0]
        $Left.position.y = player.position.y
        $Right.position.y = player.position.y
        
    if Input.is_action_just_pressed("Activate"):
        activate()
    
    if Input.is_action_just_released("Activate"):
        deactivate()


func activate():
    $Left/CollisionShape2D.disabled = true
    $Right/CollisionShape2D.disabled = true
    $Sprite/Left.modulate.a = 0.2
    $Sprite/Right.modulate.a = 0.2
    
func deactivate():
    $Left/CollisionShape2D.disabled = false
    $Right/CollisionShape2D.disabled = false
    $Sprite/Left.modulate.a = 1
    $Sprite/Right.modulate.a = 1
