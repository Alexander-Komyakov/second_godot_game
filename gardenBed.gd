extends Area2D

var sceneVegetables = preload("res://vegetables.tscn")


var is_empty: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass

func plant(sseed: String) -> void:
    is_empty = false
    var instance = sceneVegetables.instantiate()
    instance.position = Vector2.ZERO
    instance.vegatablesName = sseed.right(-5)
    add_child(instance)
    
func unplant():
    is_empty = true
