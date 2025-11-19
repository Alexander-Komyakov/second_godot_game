extends Control


var objects: Dictionary[String, int] = {
    "eggplant": 0,
    "watermelon": 0,
    "cabbage": 0,
    "money": 0,
    "seed_eggplant": 0,
    "seed_watermelon": 0,
    "seed_cabbage": 0
}

var name_to_id: Dictionary[String, int] = {
    "eggplant": 0,
    "watermelon": 1,
    "cabbage": 2,
    "money": 0,
    "seed_eggplant": 1,
    "seed_watermelon": 2,
    "seed_cabbage": 3
}

var map_interface = [
    "eggplant",
    "watermelon",
    "cabbage",
    "money",
    "seed_eggplant",
    "seed_watermelon",
    "seed_cabbage"
]

func get_select() -> String:
    var selectRight = $rightPanel.get_selected_items()
    var selectDown = $downPanel.get_selected_items()
    if selectRight.size() != 0:
        return map_interface[selectRight[0]+3]
    elif selectDown.size() != 0:    
        return map_interface[selectDown[0]]
    else:
        return ""


func get_object(object: String) -> int:
    return objects[object]

func set_object(object: String, value: int) -> void:
    objects[object] = value
    if object in ["eggplant", "watermelon", "cabbage"]:
        $downPanel.set("item_"+str(name_to_id[object])+"/text", str(value))
    else:
        $rightPanel.set("item_"+str(name_to_id[object])+"/text", str(value))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass


func _on_right_panel_item_selected(_index: int) -> void:
    $downPanel.deselect_all()


func _on_down_panel_item_selected(_index: int) -> void:
    $rightPanel.deselect_all()
