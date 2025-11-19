extends CharacterBody2D

@onready var interface = get_node("../interface")
const speed = 300.0 

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
        if sseed != "" and interface.objects[sseed] > 0 and sseed.left(4) == "seed":
            interface.set_object(sseed, interface.get_object(sseed)-1)
            create_vegetables(sseed)
        elif get_vegetables():
            pass

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
            
            
            
func create_vegetables(sseed: String) -> void:
    var areas = $InteractionArea.get_overlapping_areas()
    for area in areas:
        if area.has_method("plant"):
            if not area.is_empty:
                continue
            area.plant(sseed)
            break
