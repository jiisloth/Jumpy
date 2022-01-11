extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2.ZERO
var jump_buffer = 0
var dir = 1
var camera

var is_on_floor = false
var is_on_ceiling = false
var is_on_wall = false
# Called when the node enters the scene tree for the first time.

func _ready():
    camera = get_tree().get_nodes_in_group("Camera")
    if len(camera) > 0:
        camera = camera[0]
    else:
        camera = false
        print("no_camera")


func _process(delta):
    if is_on_floor:
        if camera:
            camera.position.y = position.y
        $AnimationPlayer.play("standing")
    else:
        $AnimationPlayer.play("jumping")
        if camera.position.y - position.y < -50:
            camera.position.y = position.y -50
    $Sprite.scale.x = dir
        

func _physics_process(delta):
    if position.x > 8*9:
        position.x -= 8*9
    if position.x < 0:
        position.x += 8*9
    if is_on_floor:
        motion = Vector2(0,1)
        if jump_buffer > 0:
            jump()
    else:
        motion.y += 10
        jump_buffer -= 1
    if is_on_ceiling:
        motion.y = 0
    if is_on_wall:
        motion.x = -motion.x
        dir = -dir
    var col = move_and_collide(motion*delta)
    is_on_floor = false
    is_on_ceiling = false
    is_on_wall = false
    if col:
        if col.normal.y == -1:
            is_on_floor = true
        if col.normal.y == 1:
            is_on_ceiling = true
        if col.normal.x != 0:
            is_on_wall = true
            

func jump():
    position.x = round((position.x)/8)*8
    motion = Vector2(dir*70, -220)

func _on_Jump_timeout():
    jump_buffer = 4
