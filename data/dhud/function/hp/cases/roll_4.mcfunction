
execute if score %blink dhud.saved_blink matches 1 run function dhud:hp/draws/roll_4/blinking
function dhud:hp/draws/roll_4/full_hearts
function dhud:hp/draws/roll_4/edge
execute if score %blink dhud.saved_blink matches 1 if score %this_hp dhud.saved_blink > %this_hp dhud.HP run function dhud:hp/draws/roll_4/half_blinking
execute if score %blink dhud.saved_blink matches 1 if score %overflow dhud.saved_blink matches 1.. run function dhud:hp/draws/roll_4/overflow