extends Area2D

var timer_growth: Timer
var vegatablesName: String = "watermelon"
#var _price: int = 2
var _time_growth: int = 0
var is_growth: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    match vegatablesName:
        "watermelon":
            #_price = 4
            $spriteSeed.frame = 2
            $spriteSeed.show()
            $spriteVegetables.frame = 2
            _time_growth = int(randf_range(4, 10))
        "eggplant":
            #_price = 5
            $spriteSeed.frame = 1
            $spriteVegetables.frame = 1
            $spriteSeed.show()
            _time_growth = int(randf_range(5, 12))
        "cabbage":
            #_price = 6
            $spriteSeed.frame = 0
            $spriteVegetables.frame = 0
            $spriteSeed.show()
            _time_growth = int(randf_range(6, 14))

    timer_growth = Timer.new()
    timer_growth.one_shot = true
    add_child(timer_growth)
    timer_growth.timeout.connect(_growth_end)
    timer_growth.start(_time_growth)
    
        
func _growth_end() -> void:
    $spriteSeed.hide()
    $spriteVegetables.show()
    is_growth = true

func harvers_plant() -> int:
    return 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass
