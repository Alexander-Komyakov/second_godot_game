extends CharacterBody2D

@onready var interface = get_node("../Camera2D/interface")
var scene: int = 0
const speed = 300.0 
var carpet_entered: bool = false
var buy_eggplant_entered: bool = false
var buy_watermelon_entered: bool = false
var buy_cabbage_entered: bool = false

func _ready():
    interface.set_object("seed_watermelon", 2)

func _physics_process(_delta: float) -> void:
    var input_direction = Input.get_vector("left", "right", "up", "down")
    velocity = input_direction * speed
    if velocity.x < 0:
        $AnimatedSprite2D.flip_h = true
    elif velocity.x > 0:
        $AnimatedSprite2D.flip_h = false
        
    if velocity.x != 0:
        $AnimationTree.set("parameters/conditions/run", true)
        $AnimationTree.set("parameters/conditions/idle", false)
    else:
        $AnimationTree.set("parameters/conditions/idle", true)
        $AnimationTree.set("parameters/conditions/run", false)

    move_and_slide()
    
func _input(event):
    if event.is_action_pressed("ui_accept"):
        var sseed: String = interface.get_select()
        if scene == 0:
            if sseed != "" and interface.objects[sseed] > 0 and sseed.left(4) == "seed":
                if create_vegetables(sseed) == true:
                    interface.set_object(sseed, interface.get_object(sseed)-1)
            get_vegetables()
        else:
            var object_interface: String = interface.get_select()
            if carpet_entered == true:
                if object_interface in ["eggplant", "watermelon", "cabbage"] and interface.objects[object_interface] > 0:
                    interface.set_object(object_interface, interface.get_object(object_interface)-1)
                    interface.set_object("money", interface.get_object("money")+interface.objects_price[object_interface])
            elif buy_eggplant_entered == true:
                print("buy eggplan")
            elif buy_watermelon_entered == true:
                print("buy watermelon")
            elif buy_cabbage_entered == true:
                print("buy cabbage")
func get_vegetables() -> String:
    var areas = $InteractionArea.get_overlapping_areas()
    for area in areas:
        if area.has_method("plant"):
            if not area.is_empty:
                var vegetable = area.get_child(2)
                if vegetable.is_growth:
                    interface.set_object(vegetable.vegatablesName, interface.get_object(vegetable.vegatablesName)+vegetable.harvers_plant())
                    vegetable.queue_free()
                    area.unplant()     
                    return "eggplant"
    return ""
            
            
            
func create_vegetables(sseed: String) -> bool:
    var areas = $InteractionArea.get_overlapping_areas()
    for area in areas:
        if area.has_method("plant"):
            if not area.is_empty:
                continue
            area.plant(sseed)
            return true
    return false


func _on_carpet_body_entered(body: Node2D) -> void:
    carpet_entered = true


func _on_carpet_body_exited(body: Node2D) -> void:
    carpet_entered = false



func _on_buy_cabbage_body_entered(body: Node2D) -> void:
    buy_cabbage_entered = true


func _on_buy_cabbage_body_exited(body: Node2D) -> void:
    buy_cabbage_entered = false


func _on_buy_watermelon_body_entered(body: Node2D) -> void:
    buy_watermelon_entered = true


func _on_buy_watermelon_body_exited(body: Node2D) -> void:
    buy_watermelon_entered = false


func _on_buy_eggplang_body_entered(body: Node2D) -> void:
    buy_eggplant_entered = true


func _on_buy_eggplang_body_exited(body: Node2D) -> void:
    buy_eggplant_entered = false
