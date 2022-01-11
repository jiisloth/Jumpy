extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    extend_sides()


func extend_sides():
    var cells = get_used_cells()
    for c in cells:
        if c.x == 8:
            var cell = get_cell(c.x, c.y)
            var autotile = get_cell_autotile_coord(c.x, c.y)
            var xpos = -1
            set_cell(xpos, c.y, cell, false, false, false, autotile)
            update_bitmask_area(Vector2(xpos,c.y))
                
