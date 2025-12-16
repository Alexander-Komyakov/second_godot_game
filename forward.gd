extends Area2D

@onready var camera = get_node("../Camera2D")
@onready var player = get_node("../player")

var tween_camera: Tween
var tween_player: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass


func _on_body_entered(_body: Node2D) -> void:
    tween_camera = create_tween()
    tween_player = create_tween()
    if camera.position.x > 0:
        player.scene = 1
        tween_camera.tween_property(camera, "position", Vector2(-683, 384), 1.8)
        tween_player.tween_property(player, "position", Vector2(-683, 384), 1.8)
    else:
        player.scene = 0
        tween_camera.tween_property(camera, "position", Vector2(683, 384), 1.8)
        tween_player.tween_property(player, "position", Vector2(683, 384), 1.8)
